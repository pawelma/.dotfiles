require 'pp'

# replace SemanticLogger subscriber for active record
if defined?(SemanticLogger)
  module ActiveRecord
    class LogSubscriber < ActiveSupport::LogSubscriber
      def sql(event)
        self.class.runtime += event.duration

        payload = event.payload

        return if IGNORE_PAYLOAD_NAMES.include?(payload[:name])

        name  = "#{payload[:name]} (#{event.duration.round(1)}ms)"
        sql   = payload[:sql]
        binds = nil

        unless (payload[:binds] || []).empty?
          binds = "  " + payload[:binds].map { |attr| render_bind(attr) }.inspect
        end

        name = colorize_payload_name(name, payload[:name])
        sql  = color(sql, sql_color(sql), true)

        debug "  #{name}  #{sql}#{binds}"
      end
    end
  end
end

# Log all ActiveRecord statements to console
begin
  require 'logger'
  ActiveRecord::Base.logger = Logger.new(STDOUT)
rescue
end

# Add custom 'benchmark' method
begin
  require 'benchmark/ips'

  def benchmark(*actions)
    return 'Nothing to benchmark!' if actions.size < 2

    actions.each do |action|
      puts "RESULT OF #{action}:"
      _execute_anything(action)
    end

    Benchmark.ips do |x|
      actions.each do |action|
        x.report(action.to_s) do
          _execute_anything(action)
        end
      end
      x.compare!
    end

    nil
  end
rescue
end

def _execute_anything(action)
  if action.respond_to?(:call)
    action.call
  elsif defined?(action)
    send(action)
  else
    eval(action)
  end
end

def ls
  puts %x{ls}
end

def ll
  puts %x{ls -al}
end

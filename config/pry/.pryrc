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

 class HashDiff
    NO_VALUE = Class.new

    def self.compare(prev, current)
      new.compare(prev, current)
    end

    def compare(prev, current)
      return compare_hashes(prev, current) if [prev, current].all?(Hash)

      raise ArgumentError, "Error - Hash expected as both input params"
    end

    private

    def compare_hashes(prev, current)
      all_keys = prev.keys | current.keys

      get_diff_with_keys(prev, current, all_keys)
    end

    def compare_arrays(prev, current)
      all_keys = (0..[prev.length, current.length].max).to_a

      get_diff_with_keys(prev, current, all_keys)
    end

    def get_diff_with_keys(prev, current, keys)
      keys.inject({}) do |acc, key|
        prev_value = prev.fetch(key, NO_VALUE)
        current_value = current.fetch(key, NO_VALUE)
        next acc if prev_value == current_value

        acc.merge({ key => get_diff(prev_value, current_value) })
      end
    end

    def get_diff(prev, current)
      return compare_hashes(prev, current) if [prev, current].all?(Hash)
      return compare_arrays(prev, current) if [prev, current].all?(Array)

      { before: prev, after: current }
    end
  end

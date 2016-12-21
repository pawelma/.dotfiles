require 'pp'

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

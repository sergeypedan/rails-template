# frozen_string_literal: true

FactoryTrace.configure do |config|
  # default ENV.key?('FB_TRACE') || ENV.key?('FB_TRACE_FILE')
  config.enabled = true

  # default is ENV['FB_TRACE_FILE']
  # when nil outputs to STDOUT
  config.path = 'log/factory_trace.txt'

  # default is true when +path+ is nil
  config.color = true

  # default is ENV['FB_TRACE'] || :full
  # can be :full or :trace_only
  config.mode = :full
end

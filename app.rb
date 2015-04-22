require 'json'
require 'newrelic_rpm'
require 'new_relic/agent/method_tracer'

class Foo
	include ::NewRelic::Agent::Instrumentation::ControllerInstrumentation 
	def crash()
		sleep(1)
		NewRelic::Agent.notice_error(StandardError.new("Here's the error"))
	end
	add_transaction_tracer :crash, :category => :task
end

Foo.new.crash
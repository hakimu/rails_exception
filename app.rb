require 'json'
require 'new_relic/agent/method_tracer'
NewRelic::Agent.manual_start(:sync_startup => true)

class Foo
	include ::NewRelic::Agent::Instrumentation::ControllerInstrumentation 
	def crash()
		# I think this API sends the class / method to the UI. Not sure?
		NewRelic::Agent.notice_error(StandardError.new("Here's the error"))
		# I'm not sure where this API is from??
		::NewRelic::Agent.agent.error_collector.notice_error(ScriptError.new("Here's the script error!!!!"))
	end
	add_transaction_tracer :crash, :category => :task
end

Foo.new.crash
::NewRelic::Agent.shutdown
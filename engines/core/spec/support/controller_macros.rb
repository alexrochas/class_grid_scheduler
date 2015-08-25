module ControllerMacros
    def set_engine_routes
        before(:each) do
            @routes = Scheduler::Core::Engine.routes
        end
    end
end

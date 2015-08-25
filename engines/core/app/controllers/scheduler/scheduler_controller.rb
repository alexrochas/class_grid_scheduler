module Scheduler
    class SchedulerController < ApplicationController
        def schedule
            render :json => {:test => "Test"}
        end
    end
end

module Scheduler
    class SchedulerController < ApplicationController
        before_action do |controller|
            unless params['config'] != nil and params['classes'] != nil
                render :json => {:error => "You provided an invalid json."}, :status => :not_found
            end
        end

        # Returns an json grid.
        # Receives config and classes to schedule an possible grid.
        def schedule
            render :json => {
                :config => params['config'],
                :classes => params['classes']
            }
        end
    end

end

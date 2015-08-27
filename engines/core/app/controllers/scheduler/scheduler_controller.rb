module Scheduler
    class SchedulerController < ApplicationController
        before_action do |controller|
            @data = params['data']
            unless @data != nil
                render :json => {:error => "You should provide data."}, :status => :not_found
            end
        end

        def schedule
            render :json => {:error => "Not implemented yet"}, :status => :not_found
        end
    end

end

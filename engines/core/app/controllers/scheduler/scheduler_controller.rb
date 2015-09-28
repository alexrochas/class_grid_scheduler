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
            classes = params['classes']
            config = params['config']

            week_days = config['week_days'].to_i
            points_per_day = config['points_per_day'].to_i
            total_points = week_days * points_per_day

            partial_points = 0
            classes.each do |class_|
                partial_points += class_['points'].to_i

            end

            while partial_points < total_points do
                #classes.push({"code"=>0, "name"=>"dummy", "points"=>"4", "teacher"=>"dummy"})
                classes.push({})
                partial_points += 4
            end

            grids = classes.permutation.to_a

            render :json => {
                :grids => grids
            }
        end
    end

end

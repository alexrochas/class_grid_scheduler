module Scheduler
    class SchedulerController < ApplicationController
        before_action do |controller|
            if params['config'] == nil or params['classes'] == nil
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

            days = (0..week_days).map{|week_day| Day.new(points_per_day)}.reduce(Array.new){|array,n| array.push(n)}

            days.
            partial_points = 0
            classes.each do |class_|
                partial_points += class_['points'].to_i
            end

            while partial_points < total_points do
                classes.push({})
                partial_points += 4
            end

            grids = classes.combination(5).to_a

            render :json => {
                :grids => grids
            }
        end
    end

    class Day
        attr_accessor :points, :classes

        def initialize(points_per_day)
            @points = points_per_day
            @classes = Array.new
        end

        def remaining_points
            return @points - self.used_points
        end

        private

        def used_points
            @classes.map{|_class| _class['points']}.reduce{:+}
        end

    end

end

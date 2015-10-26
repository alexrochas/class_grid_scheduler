module Scheduler
  class SchedulerController < ApplicationController
    before_action do |controller|
      if params['config'] == nil or params['classes'] == nil
        render :json => {:error => "You provided an invalid json."}, :status => :not_found
      end
    end

    rescue_from Exception, with: :schedule_error

    # Returns an json grid.
    # Receives config and classes to schedule an possible grid.
    def schedule
      classes = params['classes'].map{|_class| Core::Course.new_from_json(_class)}.collect()
      Struct.new("Config" ,:week_days, :points_per_day)
      config = Struct::Config.new(params['config']['week_days'].to_i, params['config']['points_per_day'].to_i)

      total_points = classes.map{|_class| _class.points}.reduce(0){|i,j| i+j}
      days_needed = total_points / config.points_per_day

      days = (1..days_needed)
        .map{|week_day| Core::Day.new(config.points_per_day)}
        .reduce(Array.new){|array,n| array.push(n)}

      classes.map{|_class| days.find{|day| day.is_full?(_class)}.classes.push(_class)}

      grids = days.combination(config.week_days).to_a

      render :json => {
        :grids => grids
      }
    end

    def schedule_error e
      render :json => {
        :error => "Ops! An error occured during class scheduling. Check your data.",
        :message => e.message
      }, :status => 406
    end

  end
end

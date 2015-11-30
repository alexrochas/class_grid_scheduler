module Scheduler
  class SchedulerController < ApplicationController
    skip_before_filter  :verify_authenticity_token
    before_action do |controller|
      data = JSON.parse(params[:data])
      if data['config'] == nil or data['classes'] == nil
        render :json => {:error => "You provided an invalid json."}, :status => :not_found
      end
    end

    rescue_from Exception, with: :schedule_error

    # Returns an json grid.
    # Receives config and classes to schedule an possible grid.
    def schedule
      data = JSON.parse(params[:data])
      classes = data['classes'].map{|_class| Core::Course.new_from_json(_class)}.collect()
      Struct.new("Config" ,:week_days, :points_per_day)
      config = Struct::Config.new(data['config']['week_days'].to_i, data['config']['points_per_day'].to_i)

      total_points = classes.map{|_class| _class.points}.reduce(0){|i,j| i+j}
      days_needed = total_points(total_points, config.points_per_day)
      days = (1..days_needed)
        .map{|week_day| Core::Day.new(config.points_per_day)}
        .reduce(Array.new){|array,n| array.push(n)}

      classes.map{|_class| days.find{|day| day.is_full?(_class)}.classes.push(_class)}

      sanitize(classes, config)

      if config.week_days > days.size
        grids = days.combination(days.size).to_a
      else
        grids = days.combination(config.week_days).to_a
      end
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

    private

      def total_points(total_points, points_per_day)
        total_points.fdiv(points_per_day).ceil
      end

      def sanitize(classes, config)
        classes.each do |class_|
          if(class_.points > config.points_per_day)
            raise "Class exceed points per day."
          end
        end
      end
  end
end

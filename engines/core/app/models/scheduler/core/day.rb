module Scheduler
  module Core
    class Day < Model::Day
      def initialize(points_per_day)
        @points = points_per_day
        @classes = Array.new
      end


      def is_full?(_class)
        remaining_points >= _class.points and not self.classes.include?(_class)
      end

      private
      def remaining_points
        return (self.points - used_points)
      end

      def used_points
        self.classes.map{|_class| _class.points}.reduce(0){|last, actual| last+actual}
      end
    end
  end
end

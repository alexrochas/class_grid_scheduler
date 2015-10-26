module Scheduler
  module Core
    class Course < Model::Course

      def self.new_from_json(json)
        _class = self.new
        _class.code = json['code']
        _class.name = json['name']
        _class.points = json['points'].to_i
        _class
      end

    end
  end
end

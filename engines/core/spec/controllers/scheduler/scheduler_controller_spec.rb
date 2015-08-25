require 'spec_helper'

module Scheduler

    describe SchedulerController do
        set_engine_routes

        context 'Scheduling' do
            describe 'GET Schedule' do
                it 'should match response test' do
                    get :schedule
                    expect(response.body).to match /test/im
                end
            end
        end
    end
end

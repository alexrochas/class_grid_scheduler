require 'spec_helper'

module Scheduler

    describe SchedulerController do
        set_engine_routes

        context 'Scheduling' do
            describe 'POST Schedule' do

                it 'should return error when no data is passed' do
                    post :schedule
                    expect(response.body).to match /You should provide data/im
                end

                it 'should receive data' do
                    post :schedule, {:data => "Test data."}
                    expect { print(request.params['data']) }
                        .to output('Test data.').to_stdout
                end

                it 'not implemented yet' do
                    post :schedule, {:data => "Test data"}
                    expect(response.body).to match /not implemented yet/im
                end
            end
        end
    end
end

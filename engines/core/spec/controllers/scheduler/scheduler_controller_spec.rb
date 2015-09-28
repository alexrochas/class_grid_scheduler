require 'spec_helper'

module Scheduler

    describe SchedulerController do
        set_engine_routes

        context 'scheduling classes' do
            describe '#schedule' do

                before(:each) do
                    file = File.open("#{Scheduler::Core::Engine.root}/spec/resources/request-data.json").read
                    @request_data = MultiJson.load(file)
                end

                context 'when data is not passed' do
                    it 'should return error message' do
                        post :schedule
                        expect(response.body).to match(/You provided an invalid json/im)
                    end
                end

                context 'when data is valid' do
                    it 'should return a grid with classes'

                    context 'when not have a possible solution' do
                        it 'should return error message'
                    end
                end

                context 'when two classes are passed to one day' do
                    it 'should return two possible forms' do
                        post :schedule, @request_data

                        given_response = MultiJson.load(response.body)
                        byebug
                        expect(given_response).to eq(expect_response)
                    end
                end
            end
        end
    end
end

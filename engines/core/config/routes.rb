Scheduler::Core::Engine.routes.draw do
    get '/schedule', to: 'scheduler#schedule'
end

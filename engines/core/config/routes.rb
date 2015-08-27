Scheduler::Core::Engine.routes.draw do
    post '/schedule', to: 'scheduler#schedule', :defaults => {:format => 'json'}
end

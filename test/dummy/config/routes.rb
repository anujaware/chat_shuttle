Rails.application.routes.draw do
  mount ChatShuttle::Engine => "/chat_shuttle"
end

Dovecote::Engine.routes.draw do
  get "/update_status" => "statuses#update", as: :update_status
end

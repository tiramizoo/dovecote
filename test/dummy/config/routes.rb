Rails.application.routes.draw do

  mount Dovecote::Engine => "/dovecote"
end

Rails.application.routes.draw do


  # you should change this entry to some other psuedo-random value...
  # just make sure it doesn't conflict with any actual paths you are serving.
  get '/ft-h1CobSYEyW9S',                       controller: 'trap', action: 'ping'


  root 'trap#index'
  get '/(:trigger)',            trigger: /.+/,  controller: 'trap', action: 'index'

end

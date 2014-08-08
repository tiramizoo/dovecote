[![Build Status](https://travis-ci.org/tiramizoo/dovecote.svg?branch=master)](https://travis-ci.org/tiramizoo/dovecote)

dovecote
========

MessageBird SMS engine for Rails application


installation
============

## Add dovecote to your app [Gemfile]

```
gem "dovecote", :github => "tiramizoo/dovecote"
```

```
bundle install
```

## Install dovecote migrations

```
rake dovecote:install:migrations
rake db:migrate
```

## mount it [config/routes.rb]

```
mount Dovecote::Engine => "/dovecote", as: :dovecote
```


## configure Dovecote

create file config/initializers/dovevote.rb

```
Dovecote.access_key = "live_XXXXXXXXXXXXXXXX" # required, MessageBird access key
Dovecote.originator = "YOUR-APP"              # optional, default: SMS
Dovecote.unicode    = true                    # optional, default: false
```

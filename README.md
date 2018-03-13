# TRack-4-You - Sinatra chalenge

## A simple example to demonstrate an user website tracking in Sinatra

The data is sent by a javascript plugin using REST to persist the user and your page navigation

```
    - Page navigation: 
        This information is saved in a localstore until the user register your email and name. 
        Once the user is register all navigation history 
        is sent to the application and saved in a database (PostgreSql).
        Any navigation after the user register will be automatically sent to the application.
    
    - User credentials: 
        This information is saved in a localstore (user name and email (used to identify the user))
```

To get the code:

`git clone https://github.com/CarlosEB/sinatra-chalenge.git`

`cd sinatra-chalenge`

run `bundle install` to install gem

Configure the postgresql credentials in config/environments.rb

run `rake db:create` to create the database

run `rake db:migrate` to create the entities

run `rackup -p $PORT` to start the application 

You can see a live [Demo](https://hero-geek.herokuapp.com/) here.
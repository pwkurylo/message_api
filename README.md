# Mesaage app

## Setup
```sh
$ git git@github.com:pwkurylo/message_api.git
$ cd message_api
$ rvm use ruby-2.7.1
$ bundle install
```

```sh
$ rails db:setup
$ rails db:migrate
```

```sh
$ rails s
```

## API
```sh
POST	/api/v1/message(.:format)	    api/v1/message#create  require params => {message: 'message'}
GET	    /api/v1/message/:id(.:format)	api/v1/message#show    require params =>  {id: 'id'}
```

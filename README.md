# walks@

## Fetch Events
`rails console` and then:
```
> Event.recent
```

## Local Setup

```
bundle install
rails db:migrate
rails s
```

## Running Tests

Headless functional testing with code coverage:

```
bundle exec rake
```

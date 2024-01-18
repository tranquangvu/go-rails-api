# Golden Owl Solutions Rails API Boilerplate

A boilerplate for quickly setting up a Ruby On Rails RESTful API

#### Features / Techstacks / Gems

- [ruby@3.3.0][https://www.ruby-lang.org/en/]
- [rails@7.1.2][https://github.com/rails/rails]
- [devise](https://github.com/heartcombo/devise)
- [devise-jwt](https://github.com/waiting-for-dev/devise-jwt)
- [pundit](https://github.com/varvet/pundit)
- [sidekiq](https://github.com/sidekiq/sidekiq)
- [sidekiq-cron](https://github.com/sidekiq-cron/sidekiq-cron)
- [pagy](https://github.com/ddnexus/pagy)
- [slim](https://github.com/slim-template/slim)
- [blueprinter](https://github.com/procore-oss/blueprinter)
- [lograge](https://github.com/roidrage/lograge)
- [annotate](https://github.com/ctran/annotate_models)
- [bullet](https://github.com/flyerhzm/bullet)
- [letter_opener](https://github.com/ryanb/letter_opener)
- [rubocop](https://github.com/rubocop/rubocop)
- [rswag](https://github.com/rswag/rswag)
- [faker](https://github.com/faker-ruby/faker)
- [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails)
- [rspec-rails](https://github.com/rspec/rspec-rails)
- [simplecov](https://github.com/simplecov-ruby/simplecov)
- [brakeman](https://github.com/presidentbeef/brakeman)
- [sentry](https://docs.sentry.io/platforms/ruby/guides/rails/)
- ...

#### Installation:

- Use ruby `3.3.0`
- Install bundler: `gem install bundler`
- Install packages: `bundle install`
- Add database configuration: add `config/database.yml` file with sample contents provided in `config/database.yml.sample`
- Add environment variables: add `.env` file with sample contents provided in `.env.sample`
- Generate new rails master key `rm -f config/credentials.yml.enc && rm -rf config/master.key && EDITOR=vim rails credentials:edit`
- Database setup: `bin/rails db:setup`
- Start rails server: `bin/rails s`
- Start worker: `bin/bundle exec sidekiq`

#### Specs:

- Run `rspec` | `bin/bundle exec rspec`
- Check coverage at `coverage/index.html`

#### API document:

- Run `bin/rake rswag`
- Visit api docs at http://localhost:3000/docs

#### Security vulnerability scanner:

- Run `bundle exec brakeman`

#### Linter with rubocop:

- Run `bundle exec rubocop`

#### License

Licensed under the MIT license, see the separate LICENSE.md file.

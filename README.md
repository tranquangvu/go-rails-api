# Rails API Template

A template for faster starting new REST API application with Ruby On Rails.

## Getting Started

1. Development:

- Use ruby `3.2.2`
- Install bundler: `gem install bundler`
- Install packages: `bundle install`
- Add database configuration: add `config/database.yml` file with sample contents provided in `config/database.sample.yml`
- Add environment variables: add `.env` file with sample contents provided in `.env.sample`
- Generate new rails master key `rm -f config/credentials.yml.enc && rm -rf config/master.key && EDITOR=vim rails credentials:edit`
- Database setup: `bin/rake db:setup`
- Start rails server: `bin/rails s`
- Start worker: `bin/bundle exec sidekiq`

2. Testing:

- Run `rspec` | `bin/bundle exec rspec`
- Check coverage at `coverage/index.html`

3. API document:

- Run `bin/rake rswag`
- Visit api docs at http://localhost:3000/api-docs

4. Security vulnerability scanner:

- Run `brakeman`

5. Linter:

- Run `rubocop`

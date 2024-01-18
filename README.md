# Golden Owl Solutions Rails API Boilerplate

A boilerplate for quickly setting up a Ruby On Rails RESTful API:

- Ruby 3.3.0
- Rails 7.1.2
- PostgreSQL Database

## Getting Started

**Installation**

- Use ruby `3.3.0`
```bash
rbenv install 3.3.0
rbenv local 3.3.0
ruby -v
```
- Install packages:
```bash
gem install bundler
bundle install
```
- Add `config/database.yml` - refer `config/database.yml.sample`
- Add `.env` - refer `.env.sample`
- Generate new rails master key
```bash
rm -f config/credentials.yml.enc && rm -f config/master.key && EDITOR=vim bin/rails credentials:edit
```
- Database setup:
```bash
bin/rails db:setup
```
- Start server:
```bash
bin/rails s
bundle exec sidekiq
```

**Specs**

```bash
bundle exec rspec
```

Check the coverage at `coverage/index.html`

**API document**

```bash
bin/rake rswag
```

Check the generated document at `http://localhost:3000/docs`

**Security vulnerability scanner**

```bash
bundle exec brakeman
```

**Linter with rubocop**

```bash
bundle exec rubocop
```

## License

Licensed under the MIT license, see the separate LICENSE.md file.

setup:
	bin/setup
	bin/rails db:seed

start:
	bin/rails s -p 3000 -b "0.0.0.0"

test:
	NODE_ENV=test bin/rails test

lint:
	bundle exec rubocop
	bundle exec slim-lint app/views

check: lint test

ci-setup:
	yarn install
	bundle install --without production development
	docker-compose up -d
	RAILS_ENV=test bin/rails db:prepare

.PHONY: test
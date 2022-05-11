# README

Hexlet tests and linter status
==============================
[![Actions Status](https://github.com/vladimir-kozyrev/rails-project-lvl3/workflows/hexlet-check/badge.svg)](https://github.com/vladimir-kozyrev/rails-project-lvl3/actions)
[![Actions Status](https://github.com/vladimir-kozyrev/rails-project-lvl3/workflows/rails/badge.svg)](https://github.com/vladimir-kozyrev/rails-project-lvl3/actions)

About
=====
This project allows creating bulletins with images that go through moderation by an administrator.
Users authenticate using GitHub accounts.

Example
=======
https://hexlet-project-lvl3.herokuapp.com/

Ruby version
============
3.0.2

Available Makefile commands
===========================
Setup the application.
```
make setup
```

Run the application.
```
make start
```

Run tests.
```
make test
```

Run linters.
```
make lint
```

Run tests and linters.
```
make check
```

Drop the database and prepare it for local development.
```
make reset-db
```

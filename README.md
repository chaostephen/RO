# Rails Olympics A Part 2 - Building a Rails Project

You have **45 minutes** for this portion of the evaluation.

This evaluation will focus on the creation of a simple CRUD Blogging
application. For this part of the evaluation you will be creating models and
controllers for users, blogs, and comments.

## File Structure

You will start with a standard Rails file structure that including pre-written
RESTful routes, HTML views, and specs. **Do not alter any of the spec files.**

## Scoring & Objective

Each passing spec will award one point, for a total of 31 points. This component
of the evaluation is estimated to take **45 minutes**. Your objective is to pass
as many specs as possible.

## Getting Started

Before you begin running the specs, make sure that you create your database:

```sh
rails db:create
```

#### Database Configuration

Every time you run `rails db:migrate`, also run
`rails db:test:load`. `db:migrate` only updates the development
database; `db:test:load` updates the test DB schema to mirror the development
DB.

You can combine both commands into one:

```sh
rails db:migrate db:test:load
```

### Data Types

You will create migration, models, and controllers for the following data types:

1. `Users` will have an `email` that is a string.
   - A `User`'s `email` will be unique.
2. `Blog`s will have a `title` that is a string, have a `body` that is text, and
  belong to a `User` (name this column `author_id`).
   - A `User` has many `Blog`s, but those `Blog`s must all have unique `title`s
     in regards to that `User`. This uniqueness should be enforced at both the
     database and model levels.
   - The `blogs` table should have only one index.
   - If a `Blog` is destroyed, then all `Comments` associated with that `Blog`
     should also be destroyed.
3. `Comment`s will have a `body` that is a string and will belong to both a
   `User` (name this column `author_id`) and a `Blog` (name this column
   `blog_id`).

All foreign keys should be indexed and have a `foreign_key` constraint.
(Remember: **You should have only one index on the `blogs` table**.)

A `User` has many `Blog`s. A `User` can comment on both their own `Blog` and
other `User`'s `Blog`s. A `Comment` can only be made onto a `Blog`.

You will only be tested on the migrations, models, and controllers. When writing
strong parameters for your controllers, you can assume all incoming parameters
will be passed in though the body of incoming requests (including foreign keys).

## Specs

As you progress though this evaluation, it is recommended that you run all of
your migrations before attempting any model specs. It is also recommended that
you finish your models and create your controller files before attempting the
controller/request specs.

**Note**: Some of the model specs test the integration of your models through
associations. **Some model specs may accordingly require implementation of more
than one model to pass.**

If a failing spec confuses you, look at the spec file to see if you can discern
what it is asking of you.

As ever, please ask your TAs any questions. If you get stuck or don't know why
something is failing; ask. TAs will let you know whether they can answer your
question, so ask anything.

### Running Specs

- `cd` into the project's root directory (__roa/blog_app__)
- `bundle install` to install dependencies
- `bundle exec rspec` to run the entire spec suite
- `bundle exec rspec spec/<spec_file_name>` to run all specs in a given spec
  file
  - for example: `bundle exec rspec spec/models/user_spec.rb`
- `bundle exec rspec spec/<spec_file_name>:<line_number>` to run the spec(s) in
  the block that contains the given line number of a given spec file
  - for example: `bundle exec rspec spec/models/user_spec.rb:1`
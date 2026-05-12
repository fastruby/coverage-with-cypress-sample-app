# README

Run `rails db:migrate` to create the DB

Run `rails test` to run the Minitest test suite

Check the coverage report: ~35%

Run `RAILS_ENV=test rails coverband:coverage_server` to start the Coverband server in one terminal

Run `yarn install` to install Cypress

Run `rails cypress:run` to run Cypress tests

Run `rails simplecov_json_report` to extract the code coverage from Coveband into a `cypress_coverage.json` (note that this command will show ~74% coverage, but it's not filtering files we don't want to count for the real coverage)

Run `rails coverage:merge` to merge both Minitest and Cypress results into one

Check the coverage report: ~52%

NOTE: Use `RAILS_ENV=test rails coverband:clear` to clear Coverband's coverage if needed

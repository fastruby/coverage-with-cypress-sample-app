desc "static HTML formatted report of Coverband code coverage"
task :simplecov_json_report do
  require "coverband"
  require "coverband/utils/html_formatter"
  require "coverband/utils/result"
  require "coverband/utils/file_list"
  require "coverband/utils/source_file"
  require "coverband/utils/lines_classifier"
  require "coverband/utils/results"

  require "simplecov"
  require "simplecov_json_formatter"

  `mkdir -p #{SimpleCov.coverage_path}`

  # For a fully static HTML that can be copied to artifacts are part of CI
  # we generate with inline assets
  ENV["SIMPLECOV_INLINE_ASSETS"] = "true"

  SimpleCovJSONFormatter::ResultExporter.send(:remove_const, "FILENAME")
  SimpleCovJSONFormatter::ResultExporter::FILENAME = "cypress_coverage.json"

  coverband_reports = Coverband::Reporters::Base.report(Coverband.configuration.store)
  Coverband::Reporters::Base.fix_reports(coverband_reports)
  result = Coverband::Utils::Results.new(coverband_reports)
  SimpleCov::Formatter::JSONFormatter.new.format(result)

  # fix json structure so it can be merged with coverage:merge
  generated_json_file = File.join(SimpleCov.coverage_path, SimpleCovJSONFormatter::ResultExporter::FILENAME)
  content = { "Cypress" => JSON.parse(File.read(generated_json_file)) }
  File.write(generated_json_file, content.to_json)
end

namespace :coverage do
  desc "Merge Minitest's and Cypress' code coverage json files into one"
  task :merge do
    require "simplecov"

    # change this if you use different json result names
    coverage_files = Dir["#{SimpleCov.coverage_path}/.resultset.json"] + Dir["#{SimpleCov.coverage_path}/cypress_coverage.json"]

    # make sure to use the `rails` profile to not add noise with files we won't test
    SimpleCov.collate coverage_files, "rails"
  end
end

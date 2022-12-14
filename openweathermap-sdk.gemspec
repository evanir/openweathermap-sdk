# frozen_string_literal: true

require_relative "lib/openweathermap/sdk/version"

Gem::Specification.new do |spec|
  spec.name = "openweathermap-sdk"
  spec.version = Openweathermap::Sdk::VERSION
  spec.authors = ["Evanir de Oliveira Junior"]
  spec.email = ["evanir.jr@gmail.com"]

  spec.summary = "Esta gem foi criada para um desafio técnico da Caiena"
  # spec.description = "TODO: Write a longer description or delete this line."
  spec.homepage = "https://github.com/evanir/openweathermap-sdk"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"
  spec.metadata["homepage_uri"] = "https://github.com/evanir/openweathermap-sdk"
  spec.metadata["source_code_uri"] = spec.homepage
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_development_dependency "rspec", "~> 3.2"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata["rubygems_mfa_required"] = "true"
end

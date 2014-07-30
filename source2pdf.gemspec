# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "source2pdf/version"
Gem::Specification.new do |spec|
  spec.name          = "source2pdf"
  spec.version       = Source2Pdf::VERSION
  spec.authors       = ["Burin Choomnuan"]
  spec.email         = ["agilecreativity@gmail.com"]
  spec.summary       = "Export any project from a given git repository or a local project directory to a single pdf file"
  spec.description   = "Export any project from a given git repository (or a local directory) to a single pdf file.
                        Combine useful features of vim_printer, html2pdf, pdfs2pdf and others
                        to produce a single pdf file for quick review."
  spec.homepage      = "https://github.com/agilecreativity/source2pdf"
  spec.license       = "MIT"
  spec.files         = Dir.glob("{bin,lib,templates}/**/*") + %w[Gemfile
                                                                 Rakefile
                                                                 source2pdf.gemspec
                                                                 README.md
                                                                 CHANGELOG.md
                                                                 LICENSE
                                                                 .rubocop.yml
                                                                 .gitignore]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "thor", "~> 0.19.1"
  spec.add_runtime_dependency "git", "~> 1.2.7"
  spec.add_runtime_dependency "agile_utils", "~> 0.2.0"
  spec.add_runtime_dependency "code_lister", "~> 0.2.0"
  spec.add_runtime_dependency "vim_printer", "~> 0.2.0"
  spec.add_runtime_dependency "html2pdf", "~> 0.2.0"
  spec.add_runtime_dependency "pdfs2pdf", "~> 0.2.0"
  spec.add_development_dependency "awesome_print", "~> 1.2.0"
  spec.add_development_dependency "bundler", "~> 1.6.2"
  spec.add_development_dependency "gem-ctags", "~> 1.0.6"
  spec.add_development_dependency "guard", "~> 2.6.1"
  spec.add_development_dependency "guard-minitest", "~> 2.3.1"
  spec.add_development_dependency "minitest", "~> 5.3"
  spec.add_development_dependency "minitest-spec-context", "~> 0.0.3"
  spec.add_development_dependency "pry", "~> 0.10.0"
  spec.add_development_dependency "pry-theme", "~> 1.1.3"
  spec.add_development_dependency "rake", "~> 10.3.2"
  spec.add_development_dependency "rubocop", "~> 0.24.1"
  spec.add_development_dependency "yard", "~> 0.8.7"
end

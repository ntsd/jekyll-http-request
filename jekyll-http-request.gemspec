# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("lib", __dir__)
require "jekyll-http-request/version"

Gem::Specification.new do |s|
  s.name          = "jekyll-http-request"
  s.version       = JekyllHTTPRequest::VERSION
  s.authors       = ["Jirawat Boonkumnerd"]
  s.email         = ["contact@ntsd.dev"]
  s.homepage      = "https://github.com/ntsd/jekyll-http-request"
  s.summary       = "Jekyll Liquid Filter for HTTP requests, helps you get HTTP response data to the page content."
  s.license       = "MIT"

  s.files         = `git ls-files app lib`.split("\n")
  s.platform      = Gem::Platform::RUBY
  s.require_paths = ["lib"]

  s.add_dependency "jekyll", ">= 3.7", "< 5.0"

  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "rake"
  s.add_development_dependency "bundler"
  s.add_development_dependency "webmock"
end

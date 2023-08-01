# frozen_string_literal: true

require "spec_helper"
require "webmock/rspec"

describe(Jekyll) do
  let(:overrides) do
    {
      "source" => source_dir,
      "destination" => dest_dir,
      "url" => "http://example.org",
    }
  end
  let(:config) do
    Jekyll.configuration(overrides)
  end
  let(:site) { Jekyll::Site.new(config) }
  let(:contents) { File.read(dest_dir("index.html")) }
  before(:each) do
    # mock http request
    WebMock.stub_request(:any, "http://example.com")
      .to_return(body: lambda { |request| request.to_json })

    site.process
  end

  it "response url" do
    expect(contents).to match("http://example.com/")
  end

  it "response method" do
    expect(contents).to match("POST")
  end

  it "request body" do
    expect(contents).to match(/{ \\"foo\\": \\"bar\\" }/)
  end

  it "response header" do
    expect(contents).to match("http://example.com/")
  end
end

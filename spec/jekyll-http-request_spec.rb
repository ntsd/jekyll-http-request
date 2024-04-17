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
  before(:each) do
    # mock http request to response the request
    WebMock.stub_request(:any, "http://example.com")
      .to_return(body: lambda { |request| request.to_json })

    site.process
  end

  # test all parameters
  let(:allContent) { File.read(dest_dir("all.html")) }
  it "response url" do
    expect(allContent).to match("http://example.com/")
  end
  it "response method" do
    expect(allContent).to match("POST")
  end
  it "request body" do
    expect(allContent).to match(/{ \\"foo\\": \\"bar\\" }/)
  end
  it "response headers" do
    expect(allContent).to match("Header")
    expect(allContent).to match("Header2")
  end

  # test default get only method
  let(:getContent) { File.read(dest_dir("get.html")) }
  it "response url" do
    expect(getContent).to match("http://example.com/")
  end
  it "response method" do
    expect(getContent).to match("GET")
  end

  # test post method with headers but no body
  let(:postContent) { File.read(dest_dir("post.html")) }
  it "response url" do
    expect(postContent).to match("http://example.com/")
  end
  it "response method" do
    expect(postContent).to match("POST")
  end
  it "response headers" do
    expect(postContent).to match("Header")
    expect(postContent).to match("Header2")
  end
end

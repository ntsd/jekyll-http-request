# frozen_string_literal: true

require "jekyll"
require "net/http"

module JekyllHTTPRequest
  module Filter
    def http_request(url, method, headers, body)
      key = url + method + headers + body
      JekyllHTTPRequest.cache.getset(key) do
        Jekyll.logger.debug("requesting %s %s %s %s" % [method, url, headers, body])

        uri = URI(url)

        case method
        when "POST"
          req = Net::HTTP::Post.new(uri)
        when "GET"
          req = Net::HTTP::Get.new(uri)
        else
          raise ScriptError.new("unsupported method: should be POST or GET got " + method)
        end

        # add headers
        if headers
          headers.split("|").each do |header|
            key, value = header.split(":")
            req[key] = value
          end
        end

        # add body
        if body
          req.body = body
        end

        # check is https
        isHTTPS = url.index("https") == 0

        # do request
        res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => isHTTPS) { |http|
          http.request(req)
        }

        # return response body and force encoding UTF-8
        return res.body.force_encoding("UTF-8")
      end
    end
  end
end

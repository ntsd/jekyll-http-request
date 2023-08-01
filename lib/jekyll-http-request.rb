# frozen_string_literal: true

module JekyllHTTPRequest
  autoload :Filter, "jekyll-http-request/filter"
  autoload :Cache, "jekyll-http-request/cache"

  class << self
    def cache
      @cache ||= if defined? Jekyll::Cache
                   Jekyll::Cache.new(self.class.name)
                 else
                  JekyllHTTPRequest::Cache.new
                 end
    end

    def reset
      JekyllHTTPRequest.cache.clear
    end
  end
end

Liquid::Template.register_filter(JekyllHTTPRequest::Filter)

# reset cache after site init https://jekyllrb.com/docs/plugins/hooks/#built-in-hook-owners-and-events
Jekyll::Hooks.register :site, :after_init do |_site|
  JekyllHTTPRequest.reset
end

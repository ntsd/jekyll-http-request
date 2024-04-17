# Jekyll HTTP Request

[![Gem Version](https://img.shields.io/gem/v/jekyll-http-request.svg)](https://rubygems.org/gems/jekyll-http-request)

Jekyll Liquid Filter for HTTP requests, helps get HTTP response data to the page content and cache.

> since many people using UTF-8 nowaday, so I have decide to force encoding the response body to UTF-8.

## Installation

1. Add `gem 'jekyll-http-request'` to your site's Gemfile.
2. run `bundle`.
3. Add the following to your site's `_config.yml`:

```yaml
plugins:
  - jekyll-http-request
```

Alternatively using git repository for gem `gem "jekyll-http-request", :git => "git://github.com/ntsd/jekyll-http-request.git"`.

## Usage

```rb
{{ <url> | http_request: <http_method>, <headers>, <body> }}
```

- `url`: url of the request.
- `http_method`: the HTTP method, only support GET and POST for now.
- `headers`: headers will separate by pipe (|) and separated key-value by colon (:).
- `body`: http request body.

\*\* The liquid filter required all parameters, set to empty string if not provided.

The response will cache to [Jekyll::Cache](https://jekyllrb.com/tutorials/cache-api/) for the next time it call the same request. The cache will clear after the site init.

## Examples

### HTTP GET

```rb
{{ 'http://httpbin.org/anything' | http_request: 'GET', '', '' }}
```

### HTTPS GET

if the url starts with `https` will force request with ssl.

```rb
{{ 'https://httpbin.org/anything' | http_request: 'GET', '', '' }}
```

### HTTP POST

```rb
{{ 'http://httpbin.org/anything' | http_request: 'POST', '', '' }}
```

### With headers

headers will separate by pipe (|) and separated key-value by colon (:).

```rb
{{ 'http://httpbin.org/anything' | http_request: 'GET', 'key:value|key2:value2', '' }}
```

### With body

```rb
{{ 'http://httpbin.org/anything' | http_request: 'POST', '', 'body' }}
```

### With JSON body

use `capture` to define `jsonBody` variable.

```rb
{% capture jsonBody %}{ "foo": "bar" }{% endcapture %}
{{ 'http://httpbin.org/anything' | http_request: 'POST', '', jsonBody }}
```

### Fetch Markdown and Render

example fetch Github README.md then render by markdownify

```rb
{{ 'https://raw.githubusercontent.com/ntsd/jekyll-http-request/main/README.md' | http_request: 'GET', '', '' | markdownify }}
```

### Unit Testing

To run unit test use `rake` command.

```rb
rake
```

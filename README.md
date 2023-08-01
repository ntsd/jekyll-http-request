# Jekyll HTTP Request

[![Gem Version](https://img.shields.io/gem/v/jekyll-http-request.svg)](https://rubygems.org/gems/jekyll-http-request)

Jekyll Liquid Filter for HTTP requests, helps you get HTTP response data to the page content.

## Installation

1. Add `gem 'jekyll-http-request'` to your site's Gemfile
2. run `bundle`
3. Add the following to your site's `\_config.yml`:

```yaml
plugins:
  - jekyll-http-request
```

## Usage

`{{ <url> | http_request: <http_method>, <headers>, <body> }}`

- `url`: url of the request
- `http_method`: only support GET and POST for now
- `headers`: headers will separate by pipe (|) and separated key-value by colon (:)
- `body`: http request body

*This liquid filter required all parameters set to empty string if not provided.

## Examples

### HTTP GET

`{{ 'http://httpbin.org/anything' | http_request: 'GET', '', '' }}`

### HTTPS GET

if the url starts with `https` will force request with ssl.

`{{ 'https://httpbin.org/anything' | http_request: 'GET', '', '' }}`

### HTTP POST

`{{ 'http://httpbin.org/anything' | http_request: 'POST', '', '' }}`

### With headers

headers will separate by pipe (|) and separated key-value by colon (:).

`{{ 'http://httpbin.org/anything' | http_request: 'GET', 'key:value|key2:value2', '' }}`

### With body

`{{ 'http://httpbin.org/anything' | http_request: 'POST', '', 'body' }}`

### With JSON body

use `capture` to define `jsonBody` variable.

```rb
{% capture jsonBody %}{ "foo": "bar" }{% endcapture %}
{{ 'http://httpbin.org/anything' | http_request: 'POST', '', jsonBody }}
```

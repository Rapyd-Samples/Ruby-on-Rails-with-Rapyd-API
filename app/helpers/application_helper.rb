module ApplicationHelper

  require 'digest'
  require 'base64'
  require 'json'
  require 'uri'
  require 'net/http'
  require 'OpenSSL'

  SALT = (0...8).map { ('a'..'z').to_a[rand(26)] }.join

  TIMESTAMP = Time.now.to_i.to_s
  SECRET_KEY = 'your-secret-key'
  ACCESS_KEY = 'your-access-key'
  REL_PATH = 'post/v1/checkout'
  BODY = ''

  def signature(body)
    to_sign = "#{REL_PATH}#{SALT}#{TIMESTAMP}#{ACCESS_KEY}#{SECRET_KEY}#{BODY}"
    mac = OpenSSL::HMAC.hexdigest("SHA256", SECRET_KEY, to_sign)
    temp_BS64 = Base64.urlsafe_encode64(mac)
    temp_BS64
  end

  def set_headers(request, body)
    request['content-type'] = 'application/json'
    request['signature'] = signature(body)
    request['salt'] = SALT
    request['timestamp'] = TIMESTAMP
    request['access_key'] = ACCESS_KEY
    request
  end

  def make_rapyd_request(method, path, body)
    uri = URI("https://sandboxapi.rapyd.net#{path}")
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      request = Net::HTTP::Post.new(uri)
      set_headers(request, body.to_json)
      http.request(request)
    end

    JSON.parse(res.body)
  end
end

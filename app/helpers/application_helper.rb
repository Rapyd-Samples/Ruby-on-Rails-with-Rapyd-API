module ApplicationHelper
  require 'digest'
  require 'base64'
  require 'json'
  require 'uri'
  require 'net/http'
  require 'openssl'

  class RapydSignature
    SALT = (0...8).map { ('a'..'z').to_a[rand(26)] }.join
    SECRET_KEY = ''
    ACCESS_KEY = ''

    def self.generate_signature(http_method, path, body)
      to_sign = "#{http_method}#{path}#{SALT}#{Time.now.to_i}#{ACCESS_KEY}#{SECRET_KEY}#{body}"
      mac = OpenSSL::HMAC.hexdigest("SHA256", SECRET_KEY, to_sign)
      temp_BS64 = Base64.urlsafe_encode64(mac)
      temp_BS64
    end

    def self.set_headers(request, http_method, path, body)
      request['content-type'] = 'application/json'
      request['signature'] = generate_signature(http_method, path, body)
      request['salt'] = SALT
      request['timestamp'] = Time.now.to_i.to_s
      request['access_key'] = ACCESS_KEY
      request
    end

    def self.make_rapyd_request(http_method, path, body)
      uri = URI("https://sandboxapi.rapyd.net#{path}")
      res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        request = http_method == 'post' ? Net::HTTP::Post.new(uri) : Net::HTTP::Get.new(uri)
        set_headers(request, http_method, path, body.to_json)
        request.body = body.to_json if http_method == 'post'
        http.request(request)
      end

      JSON.parse(res.body)
    end
  end
end

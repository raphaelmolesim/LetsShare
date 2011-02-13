require 'net/https'
require 'open-uri'

module EasyHttp
  
  def self.get url
    uri = URI.parse(URI.encode(url))
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    response = http.start { |request| request.get(url) }
    response.body
  end
  
end
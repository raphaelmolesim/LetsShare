require 'net/https'
require 'open-uri'

module EasyHttp
  
  def self.get url
    uri = URI.parse(URI.encode(url))
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    #http.open_timeout = http.read_timeout = http.ssl_timeout = 10
    
    response = http.start { |request| request.get(url) }
    response.body
  end
  
end
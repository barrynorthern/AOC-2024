# fetch.rb
require 'net/http'
require 'uri'
require 'dotenv/load'

module Fetcher
  def self.fetch_data(url)
    session_token = ENV['SESSION_TOKEN']
    uri = URI(url)
    request = Net::HTTP::Get.new(uri)
    request['Cookie'] = "session=#{session_token}"
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
    response.body
  end
end
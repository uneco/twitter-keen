require 'keen'
require 'twitter'
require 'dotenv'

Dotenv.load

client = Twitter::Streaming::Client.new do |config|
  config.consumer_key        = ENV.fetch('TWITTER_CONSUMER_KEY')
  config.consumer_secret     = ENV.fetch('TWITTER_CONSUMER_SECRET')
  config.access_token        = ENV.fetch('TWITTER_OAUTH_TOKEN')
  config.access_token_secret = ENV.fetch('TWITTER_OAUTH_TOKEN_SECRET')
end

client.user do |obj|
  case obj
  when Twitter::Tweet
    Keen.publish(:tweet, obj.to_h)
  end
end

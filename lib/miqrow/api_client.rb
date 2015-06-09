require 'twitter'
require 'json'

module MiqRow
  class ApiClient
    attr_reader :app_config_data, :user_config_data

    def initialize(user_config_path="~/.miqrow.yml")
      @app_config_data = {
        "consumer_key" => "1FYLH65CPSXKbmeqPVOP7qCX1",
        "consumer_secret" => "AmbKdhCBDY21hxupM0kyIOLUEY8Pqu1AXS877Udk2t1u7IO4WT"
      }
      @user_config_data = YAML.load File.read File.expand_path(user_config_path)

      @configs = app_config_data.merge user_config_data

      # initialize clients
      # TODO: cleanup
      config_keys = %w{consumer_key consumer_secret access_token access_token_secret}
      @rest_client = ::Twitter::REST::Client.new do |config|
        config_keys.each do |k|
          config.public_send("#{k}=", @configs[k.to_sym] || @configs[k.to_s])
        end
      end
      @streaming_client = ::Twitter::Streaming::Client.new do |config|
        config_keys.each do |k|
          config.public_send("#{k}=", @configs[k.to_sym] || @configs[k.to_s])
        end
      end
    end

    def update(tweet)
      @rest_client.update tweet
    end

    def home_timeline
      @rest_client.home_timeline.each do |t|
        yield t
      end
      @streaming_client.user do |object|
        p object unless object.is_a? ::Twitter::Streaming::DeletedTweet
        case object
        when ::Twitter::Tweet
          yield object
        end
      end
    end

    def filtered_timeline(word)
      puts "word = #{word}"
      @rest_client.search(word).take(10).each do |t|
        yield t
      end
      @streaming_client.filter(track: word) do |object|
        case object
        when ::Twitter::Tweet
          yield object
        end
      end
    end
  end
end

require 'qml'

module MiqRow
  class AppController
    include QML::Access
    register_to_qml

    property(:posts) { QML::ArrayModel.new(:tweet_text, :user_name, :user_icon) }
    property(:replies) { QML::ArrayModel.new(:tweet_text, :user_name, :user_icon) }
    property :post

    def initialize
      super()
      @client = ApiClient.new

      @thread = Thread.new do
        @client.home_timeline do |tweet|
          QML.next_tick do
            add_tweet(posts, tweet)
          end
        end
      end
    end

    def add_tweet(target, tweet)
      hash = {
        tweet_text: tweet.text,
        user_name: tweet.user.name,
        user_icon: tweet.user.profile_image_uri.to_s
      }
      puts hash
      target.unshift hash
    end

    def fetch_tweets
      posts.clear
      if @thread
        @thread.kill
      end
      #word = self.word
      nil
    end

    def update
      unless self.post.empty?
        @client.update self.post
        binding.pry
        self.post = ""
      end
    end
  end
end

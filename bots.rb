require 'twitter_ebooks'

# This is an example bot definition with event handlers commented out
# You can define and instantiate as many bots as you like

class MyBot < Ebooks::Bot
  # Configuration here applies to all MyBots
  def configure
    # Consumer details come from registering an app at https://dev.twitter.com/
    # Once you have consumer details, use "ebooks auth" for new access tokens
    self.consumer_key = ENV['CKEY']
    self.consumer_secret = ENV['CSECRET']

    # Users to block instead of interacting with
    self.blacklist = ['wldgrlc', 'kylelehk', 'friedrichsays', 'Sudieofna', 'tnietzschequote', 'NerdsOnPeriod', 'FSR', 'BafflingQuotes', 'Obey_Nxme']

    # Range in seconds to randomize delay when bot.delay is called
    self.delay_range = 1..6
  end

  def on_startup
    scheduler.every '6h' do
      # Tweet something every 24 hours
      # See https://github.com/jmettraux/rufus-scheduler
      # tweet("hi")
      # pictweet("hi", "cuteselfie.jpg")
      model = Ebooks::Model.load("model/unstablereality.model")
      tweet(model.make_statement(250))
    end

    # Toss out a tweet on startup, just to prove that everything is working
    model = Ebooks::Model.load("model/unstablereality.model")
    tweet(model.make_statement(250))
  end

  def on_message(dm)
    # Reply to a DM
    reply(dm, "Sorry, DM's aren't really my thing")
  end

  def on_follow(user)
    # Follow a user back
    # follow(user.screen_name)
  end

  def on_mention(tweet)
    # Reply to a mention
    # reply(tweet, "oh hullo")
    model = Ebooks::Model.load("model/unstablereality.model")
    reply(tweet, model.make_statement(250))
  end

  def on_timeline(tweet)
    # Reply to a tweet in the bot's timeline
    # reply(tweet, "nice tweet")
  end

  def on_favorite(user, tweet)
    # Follow user who just favorited bot's tweet
    follow(user.screen_name)
  end

  def on_retweet(tweet)
    # Follow user who just retweeted bot's tweet
    follow(tweet.user.screen_name)
  end
end

# Make a MyBot and attach it to an account
MyBot.new("WildMeltheous") do |bot|
  bot.access_token = ENV['ATOKEN'] # Token connecting the app to this account
  bot.access_token_secret = ENV['ASECRET'] # Secret connecting the app to this account
end

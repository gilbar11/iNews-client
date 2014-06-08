require 'benchmark'
require 'faraday'
require 'faraday/request/hmac'
require 'yaml'
require 'xml'


fired_stories = []
InewsClient::System.session do |inews|
  inews.queue.with_queue(Settings.config.iNEWS_Server.Current_Queue) do |queue|
    loop do
      sleep(Settings.config.interval)
      require 'pry';binding.pry
      stories = queue.stories
      stories.select {|s| s.fired? }.each do |story|
        require 'pry';binding.pry
        next if fired_stories.any? { |s| s.id == story.id }
        fired_stories << story
        puts "########## FIRE #########"
      end

    end
  end
end


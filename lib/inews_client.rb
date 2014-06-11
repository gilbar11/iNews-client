require 'savon'
require 'inews_client/queue'
require 'inews_client/system'
require 'inews_client/story_entry'

module InewsClient
  def self.watch_queue(&block)
    fired_stories = []
    interval = ENV['interval'].to_i
    interval = 2 unless interval
    InewsClient::System.session do |inews|
      inews.queue.with_queue(ENV['current_queue']) do |queue|
        loop do
          sleep(ENV['interval'].to_i)
          queue.stories.select {|s| s.fired? }.each do |story|
            next if fired_stories.any? { |s| s.id == story.id }
            fired_stories << story
            block.call(story)
          end

        end
      end
    end
  end
end



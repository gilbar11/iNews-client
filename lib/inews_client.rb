require 'savon'
require 'inews_client/queue'
require 'inews_client/system'
require 'inews_client/story_entry'

module InewsClient
  def self.watch_queue(options, &block)
    fired_stories = []
    interval = options['interval'].to_i
    interval = 2 unless interval
    InewsClient::System.session(options) do |inews|
      inews.queue.with_queue(options) do |queue|
        loop do
          sleep(interval)
          queue.stories(options).select {|s| s.fired? }.each do |story|
            next if fired_stories.any? { |s| s.id == story.id }
            fired_stories << story
            block.call(story)
          end

        end
      end
    end
  end
end



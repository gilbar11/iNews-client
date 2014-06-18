module InewsClient
  class Queue < Struct.new(:inews)
    def client_options
      {
        wsdl: "#{ENV['wsdl']}/inewswebservice/services/inewsqueue?wsdl",
        namespaces:{
          "xmlns:types" => "http://avid.com/inewsqueue/types",
        },
      }
    end

    def get_stories(options)
      num_of_stories = options['stories_to_get'].to_i
      num_of_stories = 50 unless num_of_stories
      message = {
        'types:NumberOfStoriesToGet' => "#{num_of_stories}",
        'types:IsStoryBodyIncluded' => 'true',
        'types:Navigation' => 'SAME',
      }
      client.call(:get_stories, message: message, cookies: inews.auth_cookies)
    end


    def set_current_queue(queue_full_path)
      message = {
        'types:QueueFullName' => queue_full_path,
      }
      client.call(:set_current_queue, message: message, cookies: inews.auth_cookies)
    end

    def with_queue(options, &block)
      set_current_queue(options['current_queue'])
      block.call(inews.queue)
    end

    def stories(options)
      get_stories(options).to_array(:get_stories_response, :stories).map { |story| StoryEntry.parse(story[:story_as_nsml]) }
    end

    def get_queue_records
      message = {
        'types:NumberOfRecordsToGet' => '30',
        'types:Reset' => '0',
      }
      client.call(:get_queue_records, message: message, cookies: inews.auth_cookies)
    end

    def client
      @client ||= Savon.client(client_options)
    end

    def ensure_connected!
      inews.ensure_connected!
    end
  end
end


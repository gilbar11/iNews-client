module InewsClient
  class Queue < Struct.new(:inews)
    def client_options
      {
        wsdl: "#{Settings.config.iNEWS_WSAPI.wsdl}/inewswebservice/services/inewsqueue?wsdl",
        namespaces:{
          "xmlns:types" => "http://avid.com/inewsqueue/types",
        },
      }
    end

    def get_stories
      #ensure_connected!
      message = {
        'types:NumberOfStoriesToGet' => "#{Settings.config.iNEWS_Client.NumberOfStoriesToGet}",
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

    def with_queue(queue_full_path, &block)
      set_current_queue(queue_full_path)
      block.call(inews.queue)
    end

    def stories
      get_stories.to_array(:get_stories_response, :stories).map { |story| StoryEntry.parse(story[:story_as_nsml]) }
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


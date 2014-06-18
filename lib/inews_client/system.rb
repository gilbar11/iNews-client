module InewsClient
  class System < Struct.new(:auth_cookies)
    def queue
      @queue ||= InewsClient::Queue.new(self)
    end

    def self.client_options
      {
        wsdl: "#{ENV['wsdl']}/inewswebservice/services/inewssystem?wsdl",
        namespaces:{
          "xmlns:types" => "http://avid.com/inewssystem/types",
        },
      }
    end

    def get_auth_cookies
      auth_cookies
    end

    def self.client
      Savon.client(client_options)
    end

    def self.connect(options)
      message = {
        'types:Username' => "#{options['username']}",
        'types:Password' => "#{options['password']}",
        'types:Servername' => "#{options['servername']}",
      }
      client.call(:connect, message: message)
    end

    def is_connected(auth_cookies)
      client.call(:is_connected, cookies: auth_cookies)
    end

    def ensure_connected!
      unless is_connected(auth_cookies).body[:is_connected_response][:is_connected]
        response = connect
        self.auth_cookies = response.http.cookies
      end
    end

    def self.session(options, &block)
      response = connect(options)
      auth_cookies = response.http.cookies
      if auth_cookies
        client = InewsClient::System.new(auth_cookies)
        block.call(client)
      end
    rescue Exception => e
      puts e
    ensure
      if auth_cookies
        self.client.call(:disconnect, cookies: auth_cookies)
      end
    end
  end
end

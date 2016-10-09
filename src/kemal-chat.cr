require "./kemal-chat/*"
require "kemal"
module Kemal::Chat
  # TODO Put your code here
  get "/" do
    render "views/index.ecr"
  end

  SOCKETS = [] of HTTP::WebSocket

  ws "/chat" do |socket|
    SOCKETS << socket
    socket.on_message do |message|
      SOCKETS.each {|socket| socket.send message}
    end

    socket.on_close do
      SOCKETS.delete socket
    end
  end
end

Kemal.run

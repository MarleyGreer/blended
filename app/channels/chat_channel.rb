class ChatChannel < ApplicationCable::Channel
  def subscribed
    chat = Chat.find(params[:id])
    stream_for chat
    # stream_from "some_channel"
  end
end

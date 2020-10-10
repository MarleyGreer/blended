class ChatsController < ApplicationController
  def index
    @chats = []
    Chat.all.select do |chat|
      if chat.user == current_user || chat.artist == current_user.artist
        @chats << chat
      end
    end
    @chats = Chat.order('created_at DESC')
  end
end


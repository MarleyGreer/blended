class ChatsController < ApplicationController
  def index
    @chats = if current_user.artist
      Chat.where(artist: current_user.artist).or(Chat.where(user: current_user)).order('created_at DESC')
    else
      Chat.where(user: current_user).order('created_at DESC')
    end
  end
end

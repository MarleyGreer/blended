class ChatsController < ApplicationController
  def index
    @chats = if current_user.artist
      Chat.where(artist: current_user.artist).or(Chat.where(user: current_user)).order('created_at DESC')
    else
      Chat.where(user: current_user).order('created_at DESC')
    end
  end

  def create
    @chat = Chat.new
    @chat.user = current_user
    @chat.artist = Artist.find(params[:format])
    if @chat.save
     redirect_to chat_path(@chat)
   end
  end

  def show
    @chat = Chat.find(params[:id])
    @message = Message.new
  end
end

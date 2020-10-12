class ChatsController < ApplicationController
  def index
    @chats = if current_user.artist
      Chat.where(artist: current_user.artist, artist_archive: false).or(Chat.where(user: current_user, user_archive: false)).order('created_at DESC')
    else
      Chat.where(user: current_user, user_archive: false).order('created_at DESC')
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

  def archived
    @chats = if current_user.artist
      Chat.where(artist: current_user.artist, artist_archive: true).or(Chat.where(user: current_user, user_archive: true)).order('created_at DESC')
    else
      Chat.where(user: current_user, user_archive: true).order('created_at DESC')
    end
  end

  def saved
    @chats = if current_user.artist
      Chat.where(artist: current_user.artist, artist_favourite: true, artist_archive: false).or(Chat.where(user: current_user, user_favourite: true, user_archive: false)).order('created_at DESC')
    else
      Chat.where(user: current_user, user_favourite: true, user_archive: false).order('created_at DESC')
    end
  end

  def favourites
    @chat = Chat.find(params[:id])
    toggle_favourites(@chat)
    if @chat.save
      redirect_to request.referrer
    else
      render :show
    end
  end

  def archive
    @chat = Chat.find(params[:id])
    toggle_archive(@chat)
    if @chat.save
      redirect_to request.referrer
    else
      render :show
    end
  end

  def toggle_favourites(chat)
    if chat.user == current_user && chat.user_favourite == false
      chat.user_favourite = true
    elsif chat.artist == current_user.artist && chat.artist_favourite == false
      chat.artist_favourite = true
    elsif chat.user == current_user && chat.user_favourite == true
      chat.user_favourite = false
    elsif chat.artist == current_user.artist && chat.artist_favourite == true
      chat.artist_favourite = false
    end
  end

  def toggle_archive(chat)
    if chat.user == current_user && chat.user_archive == false
      chat.user_archive = true,  (chat.user_favourite = false)
    elsif chat.artist == current_user.artist && chat.artist_archive == false
      chat.artist_archive = true, (chat.artist_favourite = false)
    elsif chat.user == current_user && chat.user_archive == true
      chat.user_archive = false
    elsif chat.artist == current_user.artist && chat.artist_archive == true
      chat.artist_archive = false
    end
  end
end

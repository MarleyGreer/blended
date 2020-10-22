class MessagesController < ApplicationController
  def create
    @chat = Chat.find(params[:chat_id])
    @message = Message.new(message_params)

    @message.user = current_user
    @message.chat = @chat
    @message.chat.user_archive = false
    @message.chat.artist_archive = false

    if @message.save
      @message.chat.save
      ChatChannel.broadcast_to(
        @chat,
        render_to_string(partial: "message", locals: { message: @message })
      )
      redirect_to chat_path(@chat, anchor: "message-#{@message.id}")
    else
      render 'chats/show'
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end
end

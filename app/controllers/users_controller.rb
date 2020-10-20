class UsersController < ApplicationController

  def show
    @user = current_user
  end

  def messages
    @messages = user_signed_in? ? current_user.received_messages : []

    respond_to do |format|
    format.html
    format.json { render json: { messages: @messages.where(read: false) } }
    end
  end
end

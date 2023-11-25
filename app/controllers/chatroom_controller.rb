class ChatroomController < ApplicationController
  before_action :require_user

  def index
    @message = Message.new 
    @messages = Message.last(10)       # Message.all
  end
end
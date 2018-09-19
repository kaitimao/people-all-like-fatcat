require 'line/bot'
class PushMessagesController < ApplicationController
  before_action :authenticate_user!

  # GET /push_messages/new
  def new
  end

  # POST /push_messages
  def create
    text = params[:text]
    Channel.all.each do |channel|
      push_to_line(channel.channel_id, text)
    end
    redirect_to '/push_messages/new'
  end

  # 傳送訊息到 line
  def push_to_line(channel_id, text)
    return nil if channel_id.nil? or text.nil?
    
    # 設定回覆訊息
    message = {
      type: 'text',
      text: text
    } 

    # 傳送訊息
    line.push_message(channel_id, message)
  end

  # Line Bot API 物件初始化
  def line
    @line ||= Line::Bot::Client.new { |config|
      config.channel_secret = 'a6ea6f35ef9bd167faca807799e7f87e'
      config.channel_token = 'ftVO1spNJ4fQI8hpiCnnk0dxMLRgxur0yMicrm9lFhZlyoLp8j1sKJQdJpmy8m0uCHqOgXQ8d6bVoymVie4TATtX2FIox+6AlVrCG8KT79LklPiMk0w1BKPY715q9hgALOMszPzTddvNyjKH9pJZNgdB04t89/1O/w1cDnyilFU='
   }
  end
end
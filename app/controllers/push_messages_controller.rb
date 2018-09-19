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
      config.channel_secret = '43c2e6e6fd198d735ffe3e7bf3b29d29'
      config.channel_token = 'PXXcr+o5uPWHsutFBgDu9Ax/daLc+bnAXylaTnQteEtTgkZY03K85yXMASVdY2pq5PwbIEqUCR1QIBgcqRPvYM4D+FFO4RoaIcBzhDgP0xBn81C0lKuXlX7WPaKhXMA6hQzUMaxfTE+xhDr1RbPCKwdB04t89/1O/w1cDnyilFU='
    }
  end
end
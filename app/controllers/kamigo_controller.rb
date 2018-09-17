require 'net/http'
require 'line/bot'

class KamigoController < ApplicationController
 	protect_from_forgery with: :null_session
  def webhook
  	  # Line Bot API 物件初始化
  	client = Line::Bot::Client.new { |config|
    config.channel_secret = '43c2e6e6fd198d735ffe3e7bf3b29d29'
    config.channel_token = 'PXXcr+o5uPWHsutFBgDu9Ax/daLc+bnAXylaTnQteEtTgkZY03K85yXMASVdY2pq5PwbIEqUCR1QIBgcqRPvYM4D+FFO4RoaIcBzhDgP0xBn81C0lKuXlX7WPaKhXMA6hQzUMaxfTE+xhDr1RbPCKwdB04t89/1O/w1cDnyilFU='


  	}
  
    # 取得 reply token
    reply_token = params['events'][0]['replyToken']

  	p "======這裡是 reply_token ======"
    p reply_token 
    p "============"

    # 設定回覆訊息
    message = {
      type: 'text',
      text: '好哦～好哦～'
    }

    # 傳送訊息
    response = client.reply_message(reply_token, message)
  	p "======這裡是 response ======"
    p response 
    p "============"
      
    # 回應 200
    head :ok
  end 
  
  def eat
    render plain: "吃土啦"
  end 

  def request_headers
    render plain: request.headers.to_h.reject{ |key, value|
      key.include? '.'
    }.map{ |key, value|
      "#{key}: #{value}"
    }.sort.join("\n")
  end

  def response_headers
    response.headers['5566'] = 'QQ'
    render plain: response.headers.to_h.map{ |key, value|
      "#{key}: #{value}"
    }.sort.join("\n")
  end

  def request_body
    render plain: request.body
  end

  def show_response_body
    puts "===這是設定前的response.body:#{response.body}==="
    render plain: "虎哇花哈哈哈"
    puts "===這是設定後的response.body:#{response.body}==="
  end

  def sent_request
    uri = URI('http://localhost:3000/kamigo/eat')
    http = Net::HTTP.new(uri.host, uri.port)
    http_request = Net::HTTP::Get.new(uri)
    http_response = http.request(http_request)

    render plain: JSON.pretty_generate({
      request_class: request.class,
      response_class: response.class,
      http_request_class: http_request.class,
      http_response_class: http_response.class
    })
  end

  def translate_to_korean(message)
    "#{message}油~"
  end

end
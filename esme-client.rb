require 'rubygems'
require 'rest_client'

class ESMEClient     
  
  @session_cookie = Hash.new
  @url                                 
  
  def session_create(token, api_endpoint_url)
    @url = api_endpoint_url
    url = @url + 'session'
    response = RestClient.post url, :token => token 
    @session_cookie = {:cookies => {:JSESSIONID => response.cookies['JSESSIONID']}}
  end
  
  def session_show  
    url = @url + 'session'  
    puts @session_cookie
    RestClient.get url, @session_cookie
  end
  
  def users
    url = @url + 'users'
    RestClient.get url, @session_cookie
  end
  
  def user_messages
    url = @url + "user/messages"
    RestClient.get url, @session_cookie
  end   
  
  def user_messages_long_poll(timeout=20)
    url = @url + "user/messages?timeout=" + timeout.to_s
    RestClient.get url, @session_cookie
  end                       
  
  def user_messages_history
    url = @url + "user/messages?history=4"
    RestClient.get url, @session_cookie
  end
  
  def user_followees 
    url = @url + 'user/' + 'followees'
    RestClient.get url, @session_cookie
  end
  
  def user_followees_add(user_id)
    url = @url + 'user/' + 'followees'
    RestClient.post url, {:userId => user_id}, @session_cookie
  end
  
  def user_followees_remove(user_id)
    url = @url + 'user/' + 'followees/' + user_id.to_s
    RestClient.delete url, @session_cookie
  end
         
end
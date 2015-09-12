namespace :message do
    task :mass_sendall_text => 'token:get' do
        url = "https://api.weixin.qq.com/cgi-bin/message/mass/sendall?access_token=#{Globals.access_token}"
        text = {:filter=>{:is_to_all=>false, :group_id=>0}, :text=>{:content=>"hello weixin"}, :msgtype=>"text"} 
    
        begin
            response = RestClient.post(url, text.to_json)
        rescue RestClient::ExceptionWithResponse => e
            raise e.response
        end
        
        body = JSON.parse(response.body)
    
        if body.key? "errcode" && body["errcode"] != 0
            raise "Wechat server returns errcode: #{body["errcode"]}, errmsg: #{body["errmsg"]}}"
        end
    end
end

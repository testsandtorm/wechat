namespace :media do
    task :upload => 'token:get' do
        url = "https://api.weixin.qq.com/cgi-bin/media/upload?access_token=#{Globals.access_token}&type=image"
        data = {:upload => {:media => File.open("ruby.png")}}
    
        begin
            response = RestClient.post(url, data)
        rescue RestClient::ExceptionWithResponse => e
            raise e.response
        end
        
        body = JSON.parse(response.body)
        if body.key?("errcode") && (body["errcode"] != 0)
            raise "Wechat server returns errcode: #{body["errcode"]}, errmsg: #{body["errmsg"]}}"
        end
    
        puts body
    end
    
    task :download => 'token:get' do
        url = "https://api.weixin.qq.com/cgi-bin/media/get?access_token=#{Globals.access_token}&media_id=UPgCF2jUp_OWMtyaaGK4iYaX21hs6dpMAA0DWHZF5iLhesu7BRWYWK85EMvRV4kd"
    
        begin
            response = RestClient.get(url)
        rescue RestClient::ExceptionWithResponse => e
            raise e.response
        end
        
        File.open("test.jpg", "w:binary").write(response.body)
        puts JSON.pretty_generate(response.headers)
        body = JSON.parse(response.body)
        if body.key?("errcode") && (body["errcode"] != 0)
            raise "Wechat server returns errcode: #{body["errcode"]}, errmsg: #{body["errmsg"]}}"
        end
    end
    
    task :media_upload => 'token:get' do
        url = "https://api.weixin.qq.com/cgi-bin/media/uploadimg?access_token=#{Globals.access_token}"
        data = {:upload => {:media => File.open("git.jpg")}}
    
        begin
            response = RestClient.post(url, data)
        rescue RestClient::ExceptionWithResponse => e
            raise e.response
        end
        
        body = JSON.parse(response.body)
        if body.key?("errcode") && (body["errcode"] != 0)
            raise "Wechat server returns errcode: #{body["errcode"]}, errmsg: #{body["errmsg"]}}"
        end
    
        puts body
    end
end

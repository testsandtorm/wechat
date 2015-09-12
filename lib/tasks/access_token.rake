namespace :token do
    task :get_appid_appsecret do
        if File.exists?(Globals.config_file)
            yml = YAML.load_file Globals.config_file
    
            if yml.key?("app_id")
                Globals.app_id = yml["app_id"]
            else
                raise "app_id is not specified in #{Globals.config_file}"
            end
    
            if yml.key?("app_secret")
                Globals.app_secret = yml["app_secret"]
            else
                raise "app_secret is not specified in #{Globals.config_file}"
            end
        else
            raise "File #{Globals.config_file} doesn't exist, it must contain app_id and app_secret which used to get access_token."
        end
    end
    
    task :get => :get_appid_appsecret do
        if File.exists?(Globals.access_token_file) && (Time.now - File.mtime(Globals.access_token_file)) < (7200 - 10)
            File.open(Globals.access_token_file) do |f|
                yml = YAML.load_file(Globals.access_token_file);
                Globals.access_token = yml["access_token"]
            end
        else
            url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{Globals.app_id}&secret=#{Globals.app_secret}"
            begin
                response = RestClient.get(url)
            rescue RestClient::ExceptionWithResponse => e
                raise e.response
            end
            
            body = JSON.parse(response.body)
    
            if body.key?("errcode") && (body["errcode"] != 0)
                raise "Wechat server returns errcode: #{body["errcode"]}, errmsg: #{body["errmsg"]}}"
            end
    
            if not body.key?("access_token")
                raise "Access token should be return here, there must be somthing wrong."
            end
    
            File.open(Globals.access_token_file, 'w') do |f|
                Globals.access_token = yml["access_token"]
                f.puts "access_token: " + body["access_token"]
            end
        end
    end
end

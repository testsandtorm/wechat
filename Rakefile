require 'yaml'
require 'rest-client'

app_id = nil;
app_secret = nil;
access_token = nil;

task :get_access_token => :get_appid_appsecret do
    access_token_file = './.access_token.yml'
    if File.exists?(access_token_file) && (Time.now - File.mtime(access_token_file)) < (7200 - 10)
        puts " Access token is still valid, skip fetching from Wechat server."
        File.open(access_token_file) do |f|
            yml = YAML.load_file(access_token_file);
            access_token = yml["access_token"]
        end
    else
        url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{app_id}&secret=#{app_secret}"
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

        File.open(access_token_file, 'w') do |f|
            f.puts "access_token: " + body["access_token"]
        end
    end
end

task :get_appid_appsecret do
    config_file = "./wechat.yml"
    if File.exists?(config_file)
        yml = YAML.load_file config_file

        if yml.key?("app_id")
            app_id = yml["app_id"]
        else
            raise "app_id is not specified in #{config_file}"
        end

        if yml.key?("app_secret")
            app_secret = yml["app_secret"]
        else
            raise "app_secret is not specified in #{config_file}"
        end
    else
        raise "File #{config_file} doesn't exist, it must contain app_id and app_secret which used to get access_token."
    end
end

task :mass_sendall_text => :get_access_token do
    url = "https://api.weixin.qq.com/cgi-bin/message/mass/sendall?access_token=#{access_token}"
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

task :media_upload_tmp => :get_access_token do
    url = "https://api.weixin.qq.com/cgi-bin/media/upload?access_token=#{access_token}&type=image"
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

task :media_get_tmp => :get_access_token do
    url = "https://api.weixin.qq.com/cgi-bin/media/get?access_token=#{access_token}&media_id=UPgCF2jUp_OWMtyaaGK4iYaX21hs6dpMAA0DWHZF5iLhesu7BRWYWK85EMvRV4kd"

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


task :media_upload => :get_access_token do
    url = "https://api.weixin.qq.com/cgi-bin/media/uploadimg?access_token=#{access_token}"
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

task :add_material => :get_access_token do
    url = "https://api.weixin.qq.com/cgi-bin/material/add_material?access_token=#{access_token}&type=image"
    data = {:media => File.open("nodejs.png")}

    begin
        response = RestClient.post(url, data)
    rescue RestClient::ExceptionWithResponse => e
        raise e.response
    end
    
    puts response
    body = JSON.parse(response.body)
    if body.key?("errcode") && (body["errcode"] != 0)
        raise "Wechat server returns errcode: #{body["errcode"]}, errmsg: #{body["errmsg"]}}"
    end

    puts body
end

task :batchget_material => :get_access_token do
    url = "https://api.weixin.qq.com/cgi-bin/material/batchget_material?access_token=#{access_token}"
    data = {type: "image", offset: 0, count: 10}

    begin
        response = RestClient.post(url, data.to_json)
    rescue RestClient::ExceptionWithResponse => e
        raise e.response
    end
    
    body = JSON.parse(response.body)
    if body.key?("errcode") && (body["errcode"] != 0)
        raise "Wechat server returns errcode: #{body["errcode"]}, errmsg: #{body["errmsg"]}}"
    end

    puts body
end

task :get_materialcount => :get_access_token do
    url = "https://api.weixin.qq.com/cgi-bin/material/get_materialcount?access_token=#{access_token}"

    begin
        response = RestClient.get(url)
    rescue RestClient::ExceptionWithResponse => e
        raise e.response
    end
    
    body = JSON.parse(response.body)
    if body.key?("errcode") && (body["errcode"] != 0)
        raise "Wechat server returns errcode: #{body["errcode"]}, errmsg: #{body["errmsg"]}}"
    end

    puts body
end

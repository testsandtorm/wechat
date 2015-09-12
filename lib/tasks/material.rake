namespace :material do
    desc "Add material"
    task :add, [:type, :name, :title, :introduction] => 'token:get' do |t, args|
        raise "Unsupported material type: #{args.type}" if not ["image", "thumb", "voice", "video"].include?(args.type)

        url = "https://api.weixin.qq.com/cgi-bin/material/add_material?access_token=#{Globals.access_token}&type=#{args.name}"
        data = {:media => File.open(args.name)}
        if :type == "video"
            data[:title] = args.title
            data[:introduction] = args.introduction
        end
     
        begin
            response = RestClient.post(url, data)
        rescue RestClient::ExceptionWithResponse => e
            raise e.response
        end
        
        body = JSON.parse(response.body)
        if body.key?("errcode") && (body["errcode"] != 0)
            raise "Wechat server returns errcode: #{body["errcode"]}, errmsg: #{body["errmsg"]}}"
        else
            puts JSON.pretty_generate(body)
        end
    end

    desc "Get material"
    task :get, [:type, :media_id] => 'token:get' do |t, args|
        raise "Unexpected media type: #{args.type}" if not ["image", "voice", "video", "news"].include?(args.type)

        url = "https://api.weixin.qq.com/cgi-bin/material/get_material?access_token=#{Globals.access_token}"
        payload = {media_id: args.media_id}
    
        begin
            response = RestClient.post(url, payload.to_json)
        rescue RestClient::ExceptionWithResponse => e
            raise e.response
        end
        
        case args.type
        when "image"
            begin
                # Trying to parse the response as JSON, if that's true, there must be something wrong when downloading the image
                body = JSON.parse(response.body)
                if body.key?("errcode") && (body["errcode"] != 0)
                    raise "Wechat server returns errcode: #{body["errcode"]}, errmsg: #{body["errmsg"]}}"
                end
            rescue JSON::ParserError => e
                # If the response can not be parsed as JSON, then it is saved as image
                File.open("#{args.media_id}.jpg", "w:binary").write(response.body)
                puts "Image saved to #{media_id}.jpg"
            end
        when "voice"
            puts "News get is not supported yet."
        when "video", "news"
            body = JSON.parse(response.body)
            if body.key?("errcode") && (body["errcode"] != 0)
                raise "Wechat server returns errcode: #{body["errcode"]}, errmsg: #{body["errmsg"]}}"
            else
                puts JSON.pretty_generate(body)
            end
        else
            puts "Impossible branch."
        end
    end
    
    desc "Get all materials"
    task :batchget, [:type, :offset, :count] => 'token:get' do |t, args|
        args.with_defaults(:type=>'image', :offset=>0, :count=>20)

        url = "https://api.weixin.qq.com/cgi-bin/material/batchget_material?access_token=#{Globals.access_token}"
        payload = {type: args.type, offset: args.offset, count: args.count}
    
        begin
            response = RestClient.post(url, payload.to_json)
        rescue RestClient::ExceptionWithResponse => e
            raise e.response
        end
        
        body = JSON.parse(response.body)
        if body.key?("errcode") && (body["errcode"] != 0)
            raise "Wechat server returns errcode: #{body["errcode"]}, errmsg: #{body["errmsg"]}}"
        else
            puts JSON.pretty_generate(body)
        end
    end
    
    desc "Get the count of materials"
    task :count => 'token:get' do
        url = "https://api.weixin.qq.com/cgi-bin/material/get_materialcount?access_token=#{Globals.access_token}"
    
        begin
            response = RestClient.get(url)
        rescue RestClient::ExceptionWithResponse => e
            raise e.response
        end
        
        body = JSON.parse(response.body)
        if body.key?("errcode") && (body["errcode"] != 0)
            raise "Wechat server returns errcode: #{body["errcode"]}, errmsg: #{body["errmsg"]}}"
        else
            puts JSON.pretty_generate(body)
        end
    end
end

namespace :message do
    namespace :mass do
        desc "Send text to specified group or all user"
        task :sendall_text, [:group_id, :text, :is_to_all] => 'token:get' do |t, args|
            args.with_defaults(:is_to_all => false)

            payload = {
                :filter => {
                    :is_to_all => args.is_to_all, 
                    :group_id => args.group_id
                }, 
                :text => {
                    :content => args.text
                }, 
                :msgtype => "text"
            } 
        
            puts post('message/mass/sendall', payload.to_json)
        end

        desc "Send image to specified group or all user"
        task :sendall_image, [:group_id, :media_id, :is_to_all] => 'token:get' do |t, args|
            args.with_defaults(:is_to_all => false)

            payload = {
                :filter => {
                    :is_to_all => args.is_to_all, 
                    :group_id => args.group_id
                }, 
                :image => {
                    :media_id=> args.media_id
                }, 
                :msgtype => "image"
            } 
        
            puts post('message/mass/sendall', payload.to_json)
        end

        desc "Send voice to specified group or all user"
        task :sendall_voice, [:group_id, :media_id, :is_to_all] => 'token:get' do |t, args|
            args.with_defaults(:is_to_all => false)

            payload = {
                :filter => {
                    :is_to_all => args.is_to_all, 
                    :group_id => args.group_id
                }, 
                :voice => {
                    :media_id=> args.media_id
                }, 
                :msgtype => "voice"
            } 
        
            puts post('message/mass/sendall', payload.to_json)
        end

        desc "Send video to specified group or all user"
        task :sendall_video, [:group_id, :media_id, :is_to_all, :title, :description] => 'token:get' do |t, args|
            args.with_defaults(:is_to_all => false, :title => "Undefiend title", :description => "Undefined description")

            response = post(Global.file_base_url + 'media/updloadvideo', {:media_id=>args.media_id, :title=>args.title, :description=>args.description}.to_json)
            response = JSON.parse(response)
            raise "Returned json must contain keys type and media_id" if not (response.key?("type") and response.key?("media_id"))
            raise "Returned media must be of type video." if response["type"] != "video"
            new_media_id = response["media_id"]

            payload = {
                :filter => {
                    :is_to_all => args.is_to_all, 
                    :group_id => args.group_id
                }, 
                :video=> {
                    :media_id=> new_media_id
                }, 
                :msgtype => "video"
            } 
        
            puts post('message/mass/sendall', payload.to_json)
        end

        desc "Send news to specified group or all user"
        task :sendall_news, [:group_id, :media_id, :is_to_all] => 'token:get' do |t, args|
            args.with_defaults(:is_to_all => false)

            payload = {
                :filter => {
                    :is_to_all => args.is_to_all, 
                    :group_id => args.group_id
                }, 
                :mpnews => {
                    :media_id => args.media_id
                }, 
                :msgtype => "mpnews"
            } 

            puts post('message/mass/sendall', payload.to_json)   
        end

        desc "Send card to specified group or all user"
        task :sendall_card, [:group_id, :media_id, :is_to_all] => 'token:get' do |t, args|
            args.with_defaults(:is_to_all => false)

            payload = {
                :filter => {
                    :is_to_all => args.is_to_all, 
                    :group_id => args.group_id
                }, 
                :wxcard=> {
                    :card_id => args.media_id
                }, 
                :msgtype => "wxcard"
            } 

            puts post('message/mass/sendall', payload.to_json)   
        end

        desc "Send text to specified users"
        task :send_text, [:text] => 'token:get' do |t, args|
            raise "At least two user's openid must be provided." if args.extras.size < 2
            payload = {
                :touser => args.extras,
                :text => {
                    :content => args.text
                }, 
                :msgtype => "text"
            }
        
            puts post('message/mass/send', payload.to_json)
        end

        desc "Send image to specified users"
        task :send_image, [:media_id] => 'token:get' do |t, args|
            raise "At least two user's openid must be provided." if args.extras.size < 2
            payload = {
                :touser => args.extras,
                :image => {
                    :media_id=> args.media_id
                }, 
                :msgtype => "image"
            } 
        
            puts post('message/mass/send', payload.to_json)
        end

        desc "Send voice to specified users"
        task :send_voice, [:media_id] => 'token:get' do |t, args|
            raise "At least two user's openid must be provided." if args.extras.size < 2
            payload = {
                :touser => args.extras,
                :voice => {
                    :media_id=> args.media_id
                }, 
                :msgtype => "voice"
            } 
        
            puts post('message/mass/send', payload.to_json)
        end

        desc "Send video to specified users"
        task :send_video, [:media_id, :title, :description] => 'token:get' do |t, args|
            raise "At least two user's openid must be provided." if args.extras.size < 2
            args.with_defaults(:title => "Undefiend title", :description => "Undefined description")

            response = post(Global.api_base_url + 'media/updloadvideo', {:media_id=>args.media_id, :title=>args.title, :description=>args.description}.to_json)
            response = JSON.parse(response)
            raise "Returned json must contain keys type and media_id" if not (response.key?("type") and response.key?("media_id"))
            raise "Returned media must be of type video." if response["type"] != "video"
            new_media_id = response["media_id"]

            payload = {
                :touser => args.extras,
                :video=> {
                    :media_id=> new_media_id,
                    :title => args.title,
                    :description => args.description
                }, 
                :msgtype => "video"
            } 
        
            puts post('message/mass/send', payload.to_json)
        end

        desc "Send news to specified users"
        task :send_news, [:media_id] => 'token:get' do |t, args|
            raise "At least two user's openid must be provided." if args.extras.size < 2
            payload = {
                :touser => args.extras,
                :mpnews => {
                    :media_id => args.media_id
                }, 
                :msgtype => "mpnews"
            } 

            puts post('message/mass/send', payload.to_json)   
        end

        desc "Send card to specified users"
        task :send_card, [:media_id] => 'token:get' do |t, args|
            raise "At least two user's openid must be provided." if args.extras.size < 2
            payload = {
                :touser => args.extras,
                :wxcard=> {
                    :card_id => args.media_id
                }, 
                :msgtype => "wxcard"
            } 

            puts post('message/mass/send', payload.to_json)   
        end

        desc "Delete a message sent out before"
        task :delete, [:msg_id] => 'token:get' do |t, args|
            puts post('message/mass/send', {:msg_id=>args.msg_id}.to_json)   
        end

        desc "Preview news to a specified user"
        task :preview_news, [:media_id, :openid] => 'token:get' do |t, args|
            payload = {
                :touser => args.openid,
                :mpnews => {
                    :media_id => args.media_id
                }, 
                :msgtype => "mpnews"
            } 

            puts post('message/mass/preview', payload.to_json)   
        end

        desc "Preview text to a specified user"
        task :preview_text, [:media_id, :openid] => 'token:get' do |t, args|
            payload = {
                :touser => args.openid,
                :text => {
                    :media_id => args.media_id
                }, 
                :msgtype => "text"
            } 

            puts post('message/mass/preview', payload.to_json)   
        end

        desc "Preview image to a specified user"
        task :preview_image, [:media_id, :openid] => 'token:get' do |t, args|
            payload = {
                :touser => args.openid,
                :image => {
                    :media_id => args.media_id
                }, 
                :msgtype => "image"
            } 

            puts post('message/mass/preview', payload.to_json)   
        end

        desc "Preview video to a specified user"
        task :preview_video, [:media_id, :openid] => 'token:get' do |t, args|
            payload = {
                :touser => args.openid,
                :mpvideo => {
                    :media_id => args.media_id
                }, 
                :msgtype => "mpvideo"
            } 

            puts post('message/mass/preview', payload.to_json)   
        end

        desc "Preview voice to a specified user"
        task :preview_voice, [:media_id, :openid] => 'token:get' do |t, args|
            payload = {
                :touser => args.openid,
                :voice => {
                    :media_id => args.media_id
                }, 
                :msgtype => "voice"
            } 

            puts post('message/mass/preview', payload.to_json)   
        end

        desc "Preview card to a specified user"
        task :preview_card, [:media_id, :openid] => 'token:get' do |t, args|
            #{
            #    "touser":"OPENID", 
            #    "wxcard":{              
            #        "card_id":"123dsdajkasd231jhksad",
            #        "card_ext": "{\"code\":\"\",\"openid\":\"\",\"timestamp\":\"1402057159\",\"signature\":\"017bb17407c8e0058a66d72dcc61632b70f511ad\"}"               
            #    }, 
            #    "msgtype":"wxcard" 
            #}

            payload = {
                :touser => args.openid,
                :wxcard => {
                    :card_id => args.media_id
                }, 
                :msgtype => "wxcard"
            } 

            puts post('message/mass/preview', payload.to_json)   
        end

        desc "Get sent status of a message"
        task :get_status, [:msg_id] => 'token:get' do |t, args|
            puts post('message/mass/get', {:msg_id=>args.msg_id}.to_json)   
        end
    end

    namespace :custom do
        desc "Send text to a specified user as custom service"
        task :send_text, [:text, :openid] => 'token:get' do |t, args|
            payload = {
                :touser => args.openid,
                :text => {
                    :content => args.text
                }, 
                :msgtype => "text"
            }
        
            puts post('message/custom/send', payload.to_json)
        end

        desc "Send image to a specified user as custom service"
        task :send_image, [:media_id, :openid] => 'token:get' do |t, args|
            payload = {
                :touser => args.openid,
                :image => {
                    :media_id=> args.media_id
                }, 
                :msgtype => "image"
            } 
        
            puts post('message/custom/send', payload.to_json)
        end

        desc "Send music to a specified user as custom service"
        task :send_music, [:media_id, :openid] => 'token:get' do |t, args|
            raise "Not implemented yet."
        end

        desc "Send voice to a specified user as custom service"
        task :send_voice, [:media_id, :openid] => 'token:get' do |t, args|
            payload = {
                :touser => args.openid,
                :voice => {
                    :media_id=> args.media_id
                }, 
                :msgtype => "voice"
            } 
        
            puts post('message/custom/send', payload.to_json)
        end

        desc "Send video to a specified user as custom service"
        task :send_video, [:media_id, :thumb_media_id, :title, :description, :openid] => 'token:get' do |t, args|
            payload = {
                :touser => args.openid,
                :video=> {
                    :media_id=> args.media_id,
                    :media_id=> args.thumb_media_id,
                    :title => args.title,
                    :description => args.description
                }, 
                :msgtype => "video"
            } 
        
            puts post('message/custom/send', payload.to_json)
        end

        desc "Send news to a specified user as custom service"
        task :send_news, [:json] => 'token:get' do |t, args|
            payload = JSON.parse(File.open(json).read) 
            puts post('message/custom/send', payload.to_json)   
        end

        desc "Send card to a specified user as custom service"
        task :send_card, [:card_id, :openid] => 'token:get' do |t, args|
            payload = {
                :touser => args.openid,
                :wxcard=> {
                    :card_id => args.card_id
                }, 
                :msgtype => "wxcard"
            } 

            puts post('message/custom/send', payload.to_json)   
        end
    end
end

namespace :qrcode do
    desc "Create ticket"
    task :create, [:scene_id, :expire_seconds] => 'token:get' do |t, args|
        if args.expire_seconds # Temporary QR code
            payload = {
                expire_seconds: args.expire_seconds, 
                action_name: "QR_SCENE", 
                action_info: {scene: {scene_id: args.scene_id}}
            }
        else # Forever QR code
            payload = {
                action_name: "QR_LIMIT_SCENE",
                action_info: {scene: {scene_id: args.scene_id}}
            }
        end
        puts post('qrcode/create', payload.to_json)
    end

    desc "Show QR code to a JPG file"
    task :show, [:ticket, :file] do |t, args|
        response = get('https://mp.weixin.qq.com/cgi-bin/showqrcode', {ticket: args.ticket}, {}, :file)
        File.open(args.file, 'w:binary') do |f|
            f.write(response)
        end
        puts "QR code saved successfully as image in #{args.file}."
    end
end

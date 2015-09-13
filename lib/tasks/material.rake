namespace :material do
    desc "Add news material"
    task :add_news, [:json] => 'token:get' do |t, args|
        payload = JSON.parse(File.open(args.json).read)
        puts post('material/add_material', payload.to_json, {type: :image})
    end

    desc "Add image material"
    task :add_image, [:name] => 'token:get' do |t, args|
        payload = {:media => File.open(args.name)}
        puts post('material/add_material', payload, {type: :image})
    end

    desc "Add voice material"
    task :add_voice, [:name] => 'token:get' do |t, args|
        payload = {:media => File.open(args.name)}
        puts post('material/add_material', payload, {type: :voice})
    end

    desc "Add thumb material"
    task :add_thumb, [:name] => 'token:get' do |t, args|
        payload = {:media => File.open(args.name)}
        puts post('material/add_material', payload, {type: :thumb})
    end

    desc "Add video material"
    task :add_video, [:name, :title, :introduction] => 'token:get' do |t, args|
        payload = {}
        payload[:media] = File.open(args.name)
        payload[:title] = args.title
        payload[:introduction] = args.introduction
     
        puts post('material/add_material', payload, {type: :video})
    end

    def get_material(type, media_id, file)
        raise "Unsupported type=#{type}" if not ["image", "voice", "video", "news"].include?(type)
        if type == "image" || type == "voice"
          format = :file
        else 
          format = :json
        end
        
        payload = {media_id: media_id}
        if format == :file
            body = post('material/get_material', payload.to_json, {}, {}, :file)
            File.open(file, 'w:binary') do |f|
              f.write(body)
            end
            puts "Save to file #{file} successfully."
        else
          puts post('material/get_material', payload.to_json, {}, {}, :json)
        end
    end

    desc "Get image material"
    task :get_image, [:media_id, :file] => 'token:get' do |t, args|
        get_material("image", args.media_id, args.file)
    end

    desc "Get voice material"
    task :get_voice, [:media_id, :file] => 'token:get' do |t, args|
        get_material("voice", args.media_id, args.file)
    end

    desc "Get video material"
    task :get_video, [:media_id] => 'token:get' do |t, args|
        get_material("video", args.media_id, args.file)
    end

    desc "Get news material"
    task :get_news, [:media_id] => 'token:get' do |t, args|
        get_material("news", args.media_id, args.file)
    end
    
    desc "Get all materials"
    task :batchget, [:type, :offset, :count] => 'token:get' do |t, args|
        args.with_defaults(:type=>'image', :offset=>0, :count=>20)
        payload = {type: args.type, offset: args.offset, count: args.count}
        puts post("material/batchget_material", payload.to_json)
    end
    
    desc "Get the count of materials"
    task :count => 'token:get' do
        puts get("material/get_materialcount")
    end
end

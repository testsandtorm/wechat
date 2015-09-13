namespace :menu do
    task :create, [:json] => 'token:get' do |t, args|
        payload = JSON.parse(File.open(args.json).read).to_json
        puts post('menu/create', payload)
    end

    task :delete => 'token:get' do 
        puts get('menu/delete')
    end

    task :get => 'token:get' do
        puts get('menu/get')
    end
end

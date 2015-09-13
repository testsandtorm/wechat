namespace :menu do
    desc "Create menu from a JSON file"
    task :create, [:json] => 'token:get' do |t, args|
        payload = JSON.parse(File.open(args.json).read).to_json
        puts post('menu/create', payload)
    end

    desc "Delete menu"
    task :delete => 'token:get' do 
        puts get('menu/delete')
    end

    desc "Get the menu as JSON"
    task :get => 'token:get' do
        puts get('menu/get')
    end
end

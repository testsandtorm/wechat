namespace :ip do
    task :get => 'token:get' do
        puts get('getcallbackip')
    end
end

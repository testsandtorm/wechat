namespace :kfaccount do
    desc "Add KF account"
    task :add, [:username, :nickname, :password] => 'token:get' do |t, args|
        args.with_defaults password: '123'
        payload = {kf_account: args.username + "@#{Globals.weixin_id}", nickname: args.nickname, password: Digest::MD5.hexdigest(args.password)}
        puts post(Globals.kfaccount_base_url + 'customservice/kfaccount/add', payload.to_json);
    end

    desc "Update KF account"
    task :update, [:username, :nickname, :password] => 'token:get' do |t, args|
        args.with_defaults password: '123'
        payload = {kf_account: args.username, nickname: args.nickname, password: args.password}
        puts post(Globals.kfaccount_base_url + 'customservice/kfaccount/update', payload.to_json);
    end

    desc "Delete KF account"
    task :delete, [:username, :nickname, :password] => 'token:get' do |t, args|
        args.with_defaults password: '123'
        payload = {kf_account: args.username, nickname: args.nickname, password: args.password}
        puts post(Globals.kfaccount_base_url + 'customservice/kfaccount/del', payload.to_json);
    end

    desc "Change head image"
    task :uploadheadimg, [:username, :image] => 'token:get' do |t, args|
        payload = {:upload => {:media => File.open(args.image)}}
        puts post(Globals.kfaccount_base_url + 'customservice/kfaccount/uploadheadimg', payload, {kf_account: args.username});
    end

    desc "List all the KF accounts"
    task :list => 'token:get' do
        puts get(Globals.api_base_url + 'customservice/getkflist')
    end
end

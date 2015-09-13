namespace :user do
    desc "List all the users with an offset next_openid"
    task :list, [:next_openid] => 'token:get' do |t, args|
        if args.next_openid
            params = {next_openid: args.next_openid}
        else
            params = {}
        end
        puts get('user/get', params)
    end

    desc "Update a user's remark"
    task :update_remark, [:openid, :remark] => 'token:get' do |t, args|
        puts post('user/info/updateremark', {openid: args.openid, remark: args.remark}.to_json)
    end

    desc "Get user information"
    task :info, [:openid] => 'token:get' do |t, args|
        puts get('user/info', {openid: args.openid, lang: 'zh_CN'})
    end

    desc "Get multiple users' information in batch"
    task :batchget_info, [:json] => 'token:get' do |t, args|
        payload = JSON.parse(File.read(json)).to_json
        puts post('user/info/batchget', payload)
    end
end

namespace :group do
    desc "Create a new group"
    task :create, [:name] => 'token:get' do |t, args|
        payload = {group: {name: args.name}}
        puts post('groups/create', payload.to_json)
    end

    desc "List information of all groups"
    task :list => 'token:get' do 
        puts get('groups/get')
    end

    desc "Get groupid of a specified user"
    task :get_groupid, [:openid] => 'token:get' do |t, args|
        puts post('groups/getid', {openid: args.openid}.to_json)
    end

    desc "Rename a specified group"
    task :rename, [:groupid, :new_name] => 'token:get' do |t, args|
        puts post('groups/update', {group: {id: args.groupid, name: args.newname}}.to_json)
    end

    desc "Move a specified user to another group"
    task :move_user, [:openid, :to_groupid] => 'token:get' do |t, args|
        puts post('groups/members/update', {openid: args.openid, to_groupid: args.to_groupid}.to_json)
    end

    desc "Remove a group"
    task :delete, [:groupid] => 'token:get' do |t, args|
        puts post('groups/delete', {group: {id: args.groupid}}.to_json)
    end
end

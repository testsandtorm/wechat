namespace :template do
    desc "Set industry"
    task :set_industry, [:id1, :id2] => 'token:get' do |t, args|
        payload = {industry_id1: args.id1, industry_id2: args.id2}
        puts post('template/api_set_industry', payload.to_json)
    end

    desc "Get template ID"
    task :get_id, [:template_id_short] => 'token:get' do |t, args|
        payload = {template_id_short: args.template_id_short}
        puts post('template/api_add_template', payload.to_json)
    end

    desc "Send template message"
    task :send_message, [:json] => 'token:get' do |t, args|
        payload = JSON.parse(File.open(args.json).read).to_json
        puts post('message/template/send', payload)
    end
end

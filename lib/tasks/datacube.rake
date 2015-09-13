namespace :datacube do
    desc "Show statistic information"
    task :get_user_summary, [:begin_date, :end_date] => 'token:get' do |t, args|
        payload = {begin_date: args.begin_date, end_date: args.end_date}.to_json
        puts post(Globals.datacube_base_url + 'getusersummary', payload)
    end

    desc "Show statistic information"
    task :get_user_cumulate, [:begin_date, :end_date] => 'token:get' do |t, args|
        payload = {begin_date: args.begin_date, end_date: args.end_date}.to_json
        puts post(Globals.datacube_base_url + 'getusercumulate', payload)
    end

    desc "Show statistic information"
    task :get_article_summary, [:begin_date, :end_date] => 'token:get' do |t, args|
        payload = {begin_date: args.begin_date, end_date: args.end_date}.to_json
        puts post(Globals.datacube_base_url + 'getarticlesummary', payload)
    end

    desc "Show statistic information"
    task :get_article_total, [:begin_date, :end_date] => 'token:get' do |t, args|
        payload = {begin_date: args.begin_date, end_date: args.end_date}.to_json
        puts post(Globals.datacube_base_url + 'getarticletotal', payload)
    end

    desc "Show statistic information"
    task :get_user_read, [:begin_date, :end_date] => 'token:get' do |t, args|
        payload = {begin_date: args.begin_date, end_date: args.end_date}.to_json
        puts post(Globals.datacube_base_url + 'getuserread', payload)
    end

    desc "Show statistic information"
    task :get_user_read_hour, [:begin_date, :end_date] => 'token:get' do |t, args|
        payload = {begin_date: args.begin_date, end_date: args.end_date}.to_json
        puts post(Globals.datacube_base_url + 'getuserreadhour', payload)
    end

    desc "Show statistic information"
    task :get_user_share, [:begin_date, :end_date] => 'token:get' do |t, args|
        payload = {begin_date: args.begin_date, end_date: args.end_date}.to_json
        puts post(Globals.datacube_base_url + 'getusershare', payload)
    end

    desc "Show statistic information"
    task :get_user_share_hour, [:begin_date, :end_date] => 'token:get' do |t, args|
        payload = {begin_date: args.begin_date, end_date: args.end_date}.to_json
        puts post(Globals.datacube_base_url + 'getusersharehour', payload)
    end

    desc "Show statistic information"
    task :get_upstream_msg, [:begin_date, :end_date] => 'token:get' do |t, args|
        payload = {begin_date: args.begin_date, end_date: args.end_date}.to_json
        puts post(Globals.datacube_base_url + 'getupstreammsg', payload)
    end

    desc "Show statistic information"
    task :get_upstream_msg_hour, [:begin_date, :end_date] => 'token:get' do |t, args|
        payload = {begin_date: args.begin_date, end_date: args.end_date}.to_json
        puts post(Globals.datacube_base_url + 'getupstreammsghour', payload)
    end

    desc "Show statistic information"
    task :get_upstream_msg_week, [:begin_date, :end_date] => 'token:get' do |t, args|
        payload = {begin_date: args.begin_date, end_date: args.end_date}.to_json
        puts post(Globals.datacube_base_url + 'getupstreammsgweek', payload)
    end

    desc "Show statistic information"
    task :get_upstream_msg_month, [:begin_date, :end_date] => 'token:get' do |t, args|
        payload = {begin_date: args.begin_date, end_date: args.end_date}.to_json
        puts post(Globals.datacube_base_url + 'getupstreammsgmonth', payload)
    end

    desc "Show statistic information"
    task :get_upstream_msg_dist, [:begin_date, :end_date] => 'token:get' do |t, args|
        payload = {begin_date: args.begin_date, end_date: args.end_date}.to_json
        puts post(Globals.datacube_base_url + 'getupstreammsgdist', payload)
    end

    desc "Show statistic information"
    task :get_upstream_msg_dist_week, [:begin_date, :end_date] => 'token:get' do |t, args|
        payload = {begin_date: args.begin_date, end_date: args.end_date}.to_json
        puts post(Globals.datacube_base_url + 'getupstreammsgdistweek', payload)
    end

    desc "Show statistic information"
    task :get_upstream_msg_dist_month, [:begin_date, :end_date] => 'token:get' do |t, args|
        payload = {begin_date: args.begin_date, end_date: args.end_date}.to_json
        puts post(Globals.datacube_base_url + 'getupstreammsgdistmonth', payload)
    end

    desc "Show statistic information"
    task :get_interface_summary, [:begin_date, :end_date] => 'token:get' do |t, args|
        payload = {begin_date: args.begin_date, end_date: args.end_date}.to_json
        puts post(Globals.datacube_base_url + 'getinterfacesummary', payload)
    end

    desc "Show statistic information"
    task :get_interface_summary_hour, [:begin_date, :end_date] => 'token:get' do |t, args|
        payload = {begin_date: args.begin_date, end_date: args.end_date}.to_json
        puts post(Globals.datacube_base_url + 'getinterfacesummaryhour', payload)
    end
end

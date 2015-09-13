def post(url, payload, params={}, header={}, expect='json')
  response = process_request('post', url, payload, params, header, expect)
  process_response(response, expect)
end

def get(url, params={}, header={}, expect='json')
  response = process_request('get', url, nil, params, header, expect)
  process_response(response, expect)
end

def process_request(type, url, payload, params, header, expect)
  expect = expect.to_s if expect.class == Symbol

  raise "Only json/file can be set as expected return type." if not ["json", "file"].include?(expect)
  raise "Only post/get HTTP types are supported." if not ["post", "get"].include?(type)

  #header[:accept] = 'application/json' if expect == 'json'
  puts url
  if not (url =~ /^http/)
    url = "https://api.weixin.qq.com/cgi-bin/" + url
  end

  raise "Query parameters must be in type of Hash." if params.class != Hash
  raise "HTTP headers must be in type of Hash." if header.class != Hash
  
  header[:params] = {}
  header[:params][:access_token] = Globals.access_token
  header[:params].merge!(params)

  begin
    if type == 'get'
      response = RestClient.get(url, header)
    else
      response = RestClient.post(url, payload, header)
    end
  rescue RestClient::ExceptionWithResponse => e
    raise e.response
  end

  return response
end

def process_response(response, expect)
  if expect == 'json'
    begin
      body = JSON.parse(response.body)
    rescue JSON::ParserError => e
      puts "Expect json returned, but something goes wrong when parsing the response.body as json."
      raise e.response
    end
    
    if body.key?("errcode") && (body["errcode"] != 0)
      raise "Wechat server returns errcode: #{body["errcode"]}, errmsg: #{body["errmsg"]}}"
    else
      return JSON.pretty_generate(body)
    end
  else
    begin
      # Trying to parse the response as JSON, if that's true, there must be something wrong
      body = JSON.parse(response.body)
      if body.key?("errcode") && (body["errcode"] != 0)
        raise "Wechat server returns errcode: #{body["errcode"]}, errmsg: #{body["errmsg"]}}"
      else
        raise "Expect file returned, but the response can be parsed as json, please check."
      end
    rescue JSON::ParserError => e
      return response.body
    end
  end
end

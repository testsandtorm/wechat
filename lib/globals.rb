class Globals
  class << self
    attr_accessor :weixin_id
    attr_accessor :app_id
    attr_accessor :app_secret
    attr_accessor :access_token
    attr_accessor :config_file
    attr_accessor :access_token_file
    attr_accessor :datacube_base_url
    attr_accessor :file_base_url
    attr_accessor :api_base_url
    attr_accessor :kfaccount_base_url

    #def initialize
    #  self.config_file = "./wechat.yml"
    #end
  end
end

Globals.config_file = "./wechat.yml"
Globals.access_token_file = './.access_token.yml'
RestClient.log = STDOUT

Globals.datacube_base_url = "https://api.weixin.qq.com/datacube/"
Globals.file_base_url = "https://file.api.weixin.qq.com/cgi-bin/"
Globals.api_base_url = "https://api.weixin.qq.com/cgi-bin/"
Globals.kfaccount_base_url = "https://api.weixin.qq.com/"

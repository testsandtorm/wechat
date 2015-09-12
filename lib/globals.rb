class Globals
  class << self
    attr_accessor :app_id
    attr_accessor :app_secret
    attr_accessor :access_token
    attr_accessor :config_file
    attr_accessor :access_token_file

    #def initialize
    #  self.config_file = "./wechat.yml"
    #end
  end
end

Globals.config_file = "./wechat.yml"
Globals.access_token_file = './.access_token.yml'

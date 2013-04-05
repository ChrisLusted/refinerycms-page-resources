module Refinery
  module PageResources
    include ActiveSupport::Configurable

    config_accessor :captions, :attach_to

    self.captions = true

    self.attach_to = [
      { :engine => 'Refinery::Page', :tab => 'Refinery::Pages::Tab' },
      { :engine => 'Refinery::Blog::Post', :tab => 'Refinery::Blog::Tab' }
    ]
  end
end

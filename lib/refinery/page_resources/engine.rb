module Refinery
  module PageResources
    class Engine < Rails::Engine
      include Refinery::Engine

      isolate_namespace Refinery

      engine_name :refinery_page_resources

      def self.register(tab)
        tab.name = "resources"
        tab.partial = "/refinery/admin/pages/tabs/resources"
      end

      initializer "register refinery_page_resources plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "page_resources"
          plugin.hide_from_menu = true
        end
      end

      config.to_prepare do
        require 'refinerycms-pages'
        Refinery::Resources.attach_to.each do |a|
          engine = a[:engine].constantize
          engine.send(:has_many_page_resources)
        end
        Refinery::Resource.module_eval do
          has_many :page_resources, :dependent => :destroy
        end
      end

      config.after_initialize do
        Refinery::PageImages.attach_to.each do |a|
          admin_tab = a[:tab].constantize
          if defined?(admin_tab)
            admin_tab.register do |tab|
              register tab
            end
          end
        end

        Refinery.register_engine(Refinery::PageResources)
      end
    end
  end
end
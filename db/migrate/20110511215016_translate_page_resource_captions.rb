class TranslatePageResourceCaptions < ActiveRecord::Migration
  def up
    Refinery::PageResource.reset_column_information
    unless defined?(Refinery::PageResource::Translation) && Refinery::PageResource::Translation.table_exists?
      Refinery::PageResource.create_translation_table!({
        :caption => :text
      }, {
        :migrate_data => true
      })
    end
  end

  def down
    Refinery::PageResource.reset_column_information

    Refinery::PageResource.drop_translation_table! :migrate_data => true
  end
end

class ActsAsFannableGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.directory "app/models"
      m.template "model.rb", "app/models/fan.rb"
      m.migration_template 'migration.rb', 'db/migrate'
    end
  end
  
  def file_name
    "acts_as_fannable_migration"
  end
end

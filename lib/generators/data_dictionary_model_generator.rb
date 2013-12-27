module Websters
  class DataDictionaryModelGenerator < ActiveRecord::Generators::ModelGenerator
    desc "This generator creates an initializer file at config/initializers"
  #   desc "This generator creates an initializer file at config/initializers"
  #   def create_initializer_file
  #     create_file "config/initializers/initializer.rb", "# Add initialization content here"
  #   end

    def create_migration_file
      migration_template "migration.rb", "db/migrate/create_#{table_name}.rb"
    end

    def create_model_file
      template 'model.rb', File.join('app/models', class_path, "#{file_name}.rb")
    end

  end
end
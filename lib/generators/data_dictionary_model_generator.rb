require "rails/generators"
require "rails/generators/active_record"


module Websters
  class DataDictionaryModelGenerator < ActiveRecord::Generators::ModelGenerator
    desc "TK TK TK"
    argument :name, :type => :string, :default => "", :banner => "e.g. DataPoint", :required => true
    argument :data_dictionary_path, :type => :string, :default => "lib/data/data_dictionary.csv", :banner => "e.g. lib/data/data_dictionary.csv"

    def get_headers
      #TODO: there should be a bare-bones default (e.g. column name first, description second, everything is a string)
      # but that should be overridden by either a config file or an argument
    end

    def read

    def self.fields_fields
      {:col_name => "string"
      :attribute_name => "string"
      :definition => "text"
      :display_name => "string"
      :datatype => "string"
      :source_basename => "string"}
    end

    def create_field_migration_file
      migration_template "field_migration.rb", "db/migrate/create_#{table_name}.rb"
    end

    def create_model_migration_file
      migration_template "model_migration.rb", "db/migrate/create_#{table_name}.rb"
    end

    def create_field_model_file
      template 'model_model.rb', File.join('app/models', class_path, "#{file_name}.rb")
    end

    def create_model_model_file
      template 'field_model.rb', File.join('app/models', class_path, "#{file_name}.rb")
    end

    def create_migration_file
      create_field_migration_file
      create_model_migration_file
    end

    def create_model_file
      create_field_model_file
      create_model_model_file
    end

    def create_rake_file
      rakefile "data_dictionary_import.rake" do
        template "import.rake"
      end
    end

  end
end
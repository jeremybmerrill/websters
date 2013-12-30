require "rails/generators"
require "rails/generators/active_record"
require "websters"
require "csv"

module Websters

  class DataDictionaryModelGenerator < ActiveRecord::Generators::Base
    desc "TK TK TK"
    argument :name, :type => :string, :banner => "camelcased name of records described by the data dictionary e.g. CodeViolation", :required => true
    argument :data_dictionary_path, :type => :string, :default => "lib/data/data_dictionary.csv", :banner => "e.g. lib/data/data_dictionary.csv"

    source_root File.expand_path('../templates', __FILE__)

    def create_field
      create_field_model_file
      create_field_migration_file
    end

    def create_model_from_data_dictionray
      create_model_migration_file
      create_model_model_file
    end

    def create_rake_file
      @model_name = table_name
      template "import.rake", "lib/tasks/data_dictionary_import.rake"
      # rakefile "data_dictionary_import.rake" do
      #   template "import.rake"
      # end
    end

    protected

      def self.fields_fields
        {:col_name => "string",
        :attribute_name => "string",
        :definition => "text",
        :display_name => "string",
        :datatype => "string",
        :source_model => "string"}
      end

      def get_headers
        #TODO: there should be a bare-bones default (e.g. column name first, description second, everything is a string)
        # but that should be overridden by either a config file or an argument
        [:column_name, :attribute_name, :definition, :display_name].map(&:to_s)
      end

      def read_csv!
        unless @fields.nil?
          return @fields
        end
        @fields = []
        CSV.new( open(data_dictionary_path, 'r'), 
                :headers => get_headers, 
                :col_sep => ",", 
                :header_converters => :symbol).
          each_with_index do |row, index|
            next if index == 1
            # Table_Name  Column_Name Attribute_Name  Definition  Column_Datatype Display_Name
            unless row[:column_name].empty?
              # a config file will be needed for a really generic processor
              # will tell us the headers, (converted to an array and passed to CSV.new )
              f = {}
              f[:col_name] = row[:column_name].gsub(/[^A-Za-z0-9]/, '').underscore
              f[:attribute_name] = row[:attribute_name]
              f[:definition] = row[:definition]
              f[:display_name] = row[:display_name]
              f[:datatype] = f[:col_name].include?("*") ? "string" : "integer"
              f[:source_model] = name
              @fields << f
            end
        end
        @fields
      end

      def create_field_migration_file
        read_csv!
        migration_template "field_migration.rb", "db/migrate/create_data_dictionary_field.rb"
      end

      def create_model_migration_file
        read_csv!
        migration_template "model_migration.rb", "db/migrate/create_#{name.underscore}.rb"
      end

      def create_field_model_file
        @fields_fields = DataDictionaryModelGenerator.fields_fields
        template 'field_model.rb', File.join('app/models', "data_dictionary_field.rb")
      end

      def create_model_model_file
        template 'model_model.rb', File.join('app/models', "#{name.underscore}.rb")
      end

  end
end

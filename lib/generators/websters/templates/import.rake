require 'csv'
require 'websters'
require 'activerecord-import'

namespace :<%= @name.underscore %> do
  task :import, [:data_path] => :environment do |t, args|
    raise ArgumentError, "You must specify a data_path to the data to import!" if args.data_path.nil?
    
    CSV.new(open(args.data_path, 'r'), 
              :headers => true, 
              :header_converters => :symbol).each_with_index do |row, i|
      if i > 0 && i % 1000 == 0
        puts "Processed #{i} records"
      end
      v = <%= @name.classify %>.new
      row.each do |k, val|
        v.send(:write_attribute, k, val)
      end
      v.save
    end
  end

  task :import_via_sql, [:data_path] => :environment do |t, args|
    raise ArgumentError, "You must specify a data_path to the data to import!" if args.data_path.nil?
    CSV.new(open(args.data_path, 'r'), 
              :headers => true, 
              :header_converters => :symbol).each_with_index do |row, i|
      if i > 0 && i % 1000 == 0
        puts "Processed #{i} records"
      end
      headers = row.headers.map{|key| key.to_s.gsub(Websters::ILLEGAL_CHARACTERS, '') }
      sql = "INSERT INTO <%= @name.underscore.pluralize %> (#{headers.join(", ")}) VALUES ('#{row.fields.join("', '")}');"
      ActiveRecord::Base.connection.execute sql
    end
  end

  task :import_quickly, [:data_path] => :environment do |t, args|
    raise ArgumentError, "You must specify a data_path to the data to import!" if args.data_path.nil?

    records = []
    CSV.new(open(args.data_path, 'r'), 
              :headers => true, 
              :header_converters => :symbol).each_with_index do |row, i|
      v = <%= @name.classify %>.new
      row.each do |k, val|
        v.send(:write_attribute, k, val)
      end
      records << v
      if i > 0 && i % 1000 == 0
        puts "Processed #{i} records"
        <%= @name.classify %>.import records
        records = []
      end
    end

  end

end
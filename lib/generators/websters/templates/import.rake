require 'csv'

namespace :import do
  task :<%= @name.underscore %>, [:data_path] => :environment do |t, args|
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
end
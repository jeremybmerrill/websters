require 'websters'
require 'rails'

module Websters
  class Railtie < Rails::Railtie
    railtie_name :websters

    generators do
      require "./lib/generators/data_dictionary_model_generator"
      require "./lib/generators/data_dictionary_model/data_dictionary_model_generator"
    end


    # rake_tasks do
    #   load "tasks/harvester.rake"
    # end
  end
end

websters
========

What is Webster's?
-------------------

A Rails plugin to automatically create a model and import data from a paired 
set of a data dictionary and a dataset. This pattern is common in government 
datasets.

Webster's creates your models, a helper model (and table) called 
DataDictionaryField with information about each field in the database,
an import script and a method on your model to get information from the
DataDictionaryField.

Is Webster's Done or Usable At All?
-----------------------------------
lol. no. maybe later.

How do I use Webster's?
-----------------------

Write a config file (or use config options?)

`rails g data_dictionary_model StopAndFrisk lib/data/data_dictionary.tsv`
`rake db:migrate`
`rake stop_and_frisk:import lib/data/dataset.csv`

Why Webster's?
--------------
Noah Webster's didn't invent the data dictionary, but he did write the first 
dictionary of American English.

TODO:
  - write data dictionary views/controller to explicate each column.
  - infer datatypes
    - 8 digits -> name matches "date" or "day", or no invalid dates MMDDYYY
    - 4 digits -> name matches "hour", "time", no invalid times, HHMM
  - blank "variable" names get rolled up into prev col
  - switch on generator whether there are headers in data_dictionary
    -
  - tests lol
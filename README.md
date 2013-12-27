websters
========

What is Webster's?
-------------------

A Rails plugin to automatically create a model and import data from a paired 
set of a data dictionary and a dataset. This pattern is common in government 
datasets.

How do I use Webster's?
-----------------------

Write a config file (or use config options?)

`rails g data_dictionary_model StopAndFrisk lib/data/data_dictionary.tsv`
`rake stop_and_frisk:import lib/data/dataset.csv`

Why Webster's?
--------------
Noah Webster's didn't invent the data dictionary, but he did write the first 
dictionary of American English.

TODO:
  write generators
  actually use the thing
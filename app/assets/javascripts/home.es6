# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Person
  constructor: (@firstName, @lastName) ->

  name: ->
    "#{@first_name} #{@last_name}"

  setName: (name) ->
    names = name.split " "

    @firstName = names[0]
    @lastName = names[1]

blake = new Person "Blake", "Williams"
blake.setName("Blake Anderson")
console.log blake.name()

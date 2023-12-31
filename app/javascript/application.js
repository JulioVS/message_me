// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// Loads all Semantic javascripts
//= require jquery
//= require semantic-ui

// FIX Semantic UI Javascript
import "@hotwired/turbo-rails"
import * as jquery from "jquery"
import "semantic-ui"

$(document).on('turbo:load', function() {
  console.log('loaded turbo links')
  $('.ui.dropdown').dropdown()
});

import "channels"

$(document).on('turbo:load', function() {
  if ($('#messages').length > 0) { 
    $('#messages').scrollTop($('#messages')[0].scrollHeight);
  }
}) 

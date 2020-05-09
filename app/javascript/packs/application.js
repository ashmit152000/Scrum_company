// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
import "bootstrap"


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

$(document).on('turbolinks:load',function(){
  $('.create_project').on('click',function(){
    $('.modal').show();
});

$('.select_input').click(function(){
    $('#choose_image').click();
})




})


$(document).on('turbolinks:load',function(){

  var name;
  var description;
  var start_date;
  var dead_line;


$('#name').change(function(){
  name = $(this).val();
})

$('#description').change(function(){
  description = $(this).val();
})

$('#start_date').change(function(){
  start_date = $(this).val();
})

$('#dead_line').change(function(){
  dead_line = $(this).val();
})







  $('.create_project').click(function(){



    $.ajax({
  url: "/projects",
    type: "post",
    data: "name=" + name + "&description=" + description + "&start_date=" + start_date + "&dead_line=" + dead_line,
    success: function(data) {
        location.reload();
    },
    error: function(data) {
          location.reload();
    }
});

  })


  $('.slide').slideDown(function(){
    $(this).slideUp();
  }).delay(2000);


  var project_id = $('#project-id').val();

  $('.members-btn').click(function(){
      $.ajax({
        url: '/memberships',
        type: 'post',
        data: "project_id=" + project_id,

        success: function(data){

        },

        error: function(data){

        }
      })

  })







  var project = $('#project').val();





// $('#members-select').waypoint(function() {
//    alert('The element has appeared on the screen.');
// });


$(document).on('click','#members-select',function(){

      var rank = $('#rank').val();

      $(document).on('change','#rank',function(){
          rank = $('#rank').val();
      });


      var user = $('#user').val();

      // alert(project + " " +)

      ajaxMembers(user,project,rank);

});

  $('#member').keypress(function(e){
    if(e.which == 13){
      $('.search-members').click();
    }
  })


  var ajaxMembers = function(user,project,rank){
      $.ajax({
    url: "/memberships",
      type: "post",
      data: "user=" + user + "&project=" + project + "&rank=" + rank,
      success: function(data) {
          location.reload();
      },
      error: function(data) {
            location.reload();
      }
    });
  }



})

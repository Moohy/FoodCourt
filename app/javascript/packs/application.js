// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");
global.toastr = require("toastr");
import "../stylesheets/application";
// require("src/cocoon");
import "cocoon-js";
// import("../../views/order_lines/new.js");

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

//= require jQuery
//= require rails-ujs
//= require turbolinks
//= require bootstrap
//= require_tree .

import "../css/application.css";

const setup = () => {
  console.log("satup");
  //   $("#place-oerder")
  //     .trigger()
  //     .click();

  var menu_id = [];
  var order_id = [];
  jQuery("#cards .card").each(function() {
    menu_id.push(
      $(this)
        .get(0)
        .id.split("-")[0]
    );
    order_id.push(
      $(this)
        .get(0)
        .id.split("-")[1]
    );
  });

  var counter = 0;
  jQuery("input.menu_id").each(function() {
    $(this).val(menu_id[counter]);
    counter++;
  });

  jQuery("input.order_id").val(order_id[0]);
};
setTimeout(function() {
  $("#alert").slideUp(500);
}, 1000);
setTimeout(function() {
  $("#notice").slideUp(500);
}, 1000);

$("#alert").fadeOut(3000);

$(document).ready(function() {
  setup();
  //   $(".link-to-new-order")
  //     .first()
  //     .trigger("click");
  //   setup();
  $(".link-to-new-order")[0].click();
  var quantity = 0;
  var cart = 0;

  //   $(".quantity_down").each(function() {
  $(".quantity_down").click(function() {
    quantity = $(this)
      .next(".cart_quantity")
      .html();
    quantity--;
    cart--;
    if (quantity < 0 || cart < 0) {
      cart = 0;
      quantity = 0;
    }
    $(this)
      .next(".cart_quantity")
      .text(quantity);
    // let cart = $(this)
    //   .next(".cart_quantity")
    //   .html();
    jQuery("input.cart_quantity").val(cart);
  });

  $(".quantity_up").click(function() {
    // $(" .link-to-new-order").trigger("click");
    quantity = $(this)
      .prev(".cart_quantity")
      .html();
    quantity++;
    cart++;
    $(this)
      .prev(".cart_quantity")
      .text(quantity);
    // let cart = $(this)
    //   .prev(".cart_quantity")
    //   .html();
    jQuery("input.cart_quantity").val(cart);
    setup();
    // jQuery("input.menu_id").val(menu_id);
  });
  //   });

  // $(".cart_quantity").val(quantity);
});

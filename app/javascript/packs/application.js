// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import "controllers"

Rails.start();
Turbolinks.start();
ActiveStorage.start();

// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
// import "select2";
// import "select2/dist/css/select2.css";
// import $ from "jquery";
// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';
import { initAos } from "plugins/init_aos";
import { initPrice } from "plugins/init_price";
// import { initChartkick } from "plugins/init_chartkick";
import { initSelect } from "plugins/init_select2";

document.addEventListener("turbolinks:load", () => {
  // Call your functions here, e.g:
  // initSelect2();
  initAos();
  // initChartkick();
  // $("#search_topic").select2({
  //   placeholder: "Select a topic",
  // });

  initPrice()
});

initSelect()

// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
import flatpickr from 'flatpickr';
import 'flatpickr/dist/flatpickr.min.css'

// Internal imports, e.g:
import { initChatCable } from '../channels/chat_channel';

import { datepicker } from "../components/calender";
import { addDuration} from "../components/service_bookings"

import { initMapbox } from '../plugins/init_mapbox';
import { initAutocomplete } from '../plugins/init_autocomplete';

import { togglesearch } from '../components/search';

document.addEventListener('turbolinks:load', () => {
    togglesearch();

    addDuration();
    initChatCable();
    datepicker();

    initChatCable();
    initMapbox();
    initAutocomplete();

});


import "controllers"

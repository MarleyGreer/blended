// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require('jquery')
require('components/holidays')
require('components/workinghours')

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
import 'flatpickr/dist/flatpickr.min.css';

// Internal imports, e.g:
import { initChatCable } from '../channels/chat_channel';

import { datepicker } from "../components/calender";
import { addDuration, enablebutton, confirmbtn} from "../components/service_bookings"
import { initSortable } from '../plugins/init_sortable';
import { initMapbox } from '../plugins/init_mapbox';
import { initAutocomplete } from '../plugins/init_autocomplete';
import { togglesearch } from '../components/search';
import { bindButton } from '../plugins/init_bindbutton';



document.addEventListener('turbolinks:load', () => {
    togglesearch();
    initSortable('#bookmarks-list');
    initSortable('#photos-list');
    initMapbox();
    bindButton();
    addDuration();
    initChatCable();
    initAutocomplete();
    datepicker();
    enablebutton();
    confirmbtn();
});

import "controllers"

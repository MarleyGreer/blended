import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.querySelector('.location-form');
  if (addressInput) {
    places({ container: addressInput });
  }
};

export { initAutocomplete };

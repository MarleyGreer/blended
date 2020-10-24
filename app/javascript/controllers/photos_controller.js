import ApplicationController from './application_controller'

/* This is the custom StimulusReflex controller for the Photos Reflex.
 * Learn more at: https://docs.stimulusreflex.com
 */
export default class extends ApplicationController {

      sort(event) {

        let element = document.getElementById('photos-list')
        let photo_elements = document.getElementsByClassName('photo-item')
        let photos = Array.from(photo_elements).map((photo, index) => {
          return { id: photo.dataset.photoId, position: (index + 1) }
        })
        element.dataset.photos = JSON.stringify(photos)
        this.stimulate('PhotosReflex#sort', element)
      }
  }
  /*
   * Regular Stimulus lifecycle methods
   * Learn more at: https://stimulusjs.org/reference/lifecycle-callbacks
   *
   * If you intend to use this controller as a regular stimulus controller as well,
   * make sure any Stimulus lifecycle methods overridden in ApplicationController call super.
   *
   * Important:
   * By default, StimulusReflex overrides the -connect- method so make sure you
   * call super if you intend to do anything else when this controller connects.
  */

  // connect () {
  //   super.connect()
  //   // add your code here, if applicable
  // }

  /* Reflex specific lifecycle methods.
   *
   * For every method defined in your Reflex class, a matching set of lifecycle methods become available
   * in this javascript controller. These are optional, so feel free to delete these stubs if you don't
   * need them.
   *
   * Important:
   * Make sure to add data-controller="photos" to your markup alongside
   * data-reflex="Photos#dance" for the lifecycle methods to fire properly.
   *
   * Example:
   *
   *   <a href="#" data-reflex="click->Photos#dance" data-controller="photos">Dance!</a>
   *
   * Arguments:
   *
   *   element - the element that triggered the reflex
   *             may be different than the Stimulus controller's this.element
   *
   *   reflex - the name of the reflex e.g. "Photos#dance"
   *
   *   error/noop - the error message (for reflexError), otherwise null
   *
   *   reflexId - a UUID4 or developer-provided unique identifier for each Reflex
   */

  // Assuming you create a "Photos#dance" action in your Reflex class
  // you'll be able to use the following lifecycle methods:

  // beforeDance(element, reflex, noop, reflexId) {
  //  element.innerText = 'Putting dance shoes on...'
  // }

  // danceSuccess(element, reflex, noop, reflexId) {
  //   element.innerText = 'Danced like no one was watching! Was someone watching?'
  // }

  // danceError(element, reflex, error, reflexId) {
  //   console.error('danceError', error);
  //   element.innerText = "Couldn't dance!"
  // }


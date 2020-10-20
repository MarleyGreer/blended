
const initImageUpload = box => {
  const uploadField = box.querySelector('.image-upload');

  const getFile = (e) => {
    let file = e.currentTarget.files[0];
    previewImage(file);
  }

  const previewImage = (file) => {
    const thumb = box.querySelector('.js--image-preview'),
        reader = new FileReader();

    reader.onload = function() {
      thumb.style.backgroundImage = 'url(' + reader.result + ')';
    }
    reader.readAsDataURL(file);
    thumb.className += ' js--no-default';
  }

    uploadField.addEventListener('change', getFile);
}

// initialize box-scope
const box = document.querySelector('.box');

initImageUpload(box);

export {initImageUpload}

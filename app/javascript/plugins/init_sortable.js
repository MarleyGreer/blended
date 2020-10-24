import Sortable from 'sortablejs';
import "controllers"

const initSortable = (element) => {
  const list = document.querySelector(element);
  if (list) {
  Sortable.create(list, {
    ghostClass: "ghost",
     animation: 150,
    onSort: function(event) {
      console.log('sorted');
      // list.dispatchEvent(new Event("drop"));

    }
  });
 };
}
export { initSortable };

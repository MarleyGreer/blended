import Sortable from 'sortablejs';
import "controllers"

const initSortable = () => {
  const list = document.querySelector('#bookmarks-list');
  Sortable.create(list, {
    ghostClass: "ghost",
    animation: 150,
    onSort: function(event) {
      list.dispatchEvent(new Event("drop"));
    }
  });
};

export { initSortable };

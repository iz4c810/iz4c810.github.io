/*
const wallpaper = {
  KEY: 'wb-wallpapers',
  _items: [],
  _currentId: null,

  init() {
    this._items = JSON.parse(localStorage.getItem(this.KEY) || '[]');
  },

  _save() {
    localStorage.setItem(this.KEY, JSON.stringify(this._items));
  },

  add(event) {
    const form = event.target;
    const file = form.image.files[0];
    if (!file) return;

    const reader = new FileReader();
    reader.onload = (e) => {
      const item = {
        id: Date.now(),
        title: form.title.value,
        tags: form.tags.value.split(',').map(t => t.trim()).filter(Boolean),
        src: e.target.result,   // base64 data URL
        added: new Date().toISOString()
      };
      this._items.unshift(item);
      this._save();
      ui.render();
      form.reset();
    };
    reader.readAsDataURL(file);
  },

  delete() {
    this._items = this._items.filter(w => w.id !== this._currentId);
    this._save();
    ui.closePreview();
    ui.render();
  },

  get(id) { return this._items.find(w => w.id === id); },

  sort(mode) {
    if (mode === 'newest')  this._items.sort((a,b) => b.added - a.added);
    if (mode === 'oldest')  this._items.sort((a,b) => a.added - b.added);
    if (mode === 'name')    this._items.sort((a,b) => a.title.localeCompare(b.title));
    ui.render();
  },

  filter(query) {
    const q = query.toLowerCase();
    ui.render(this._items.filter(w =>
      w.title.toLowerCase().includes(q) ||
      w.tags.some(t => t.toLowerCase().includes(q))
    ));
  }
};   
*/

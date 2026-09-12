const ui = {
  openUpload() { document.getElementById('upload-modal').showModal(); },

  closePreview() { document.getElementById('preview-modal').close(); },

  openPreview(id) {
    const w = wallpaper.get(id);
    if (!w) return;
    wallpaper._currentId = id;
    document.getElementById('preview-img').src = w.src;
    document.getElementById('preview-meta').textContent =
      `${w.title}  ·  ${w.tags.join(', ') || 'no tags'}  ·  ${new Date(w.added).toLocaleDateString()}`;
    document.getElementById('preview-modal').showModal();
  },

  render(items) {
    const list = items || wallpaper._items;
    const grid = document.getElementById('gallery');
    grid.innerHTML = list.map(w => `
      <div class="card" onclick="ui.openPreview(${w.id})">
        <img src="${w.src}" alt="${w.title}" loading="lazy">
        <span class="label">${w.title}</span>
      </div>
    `).join('') || '<p style="padding:2rem">No wallpapers yet. Click "+ Add" to start.</p>';
  }
};   

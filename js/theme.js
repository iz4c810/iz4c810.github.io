const theme = {
  toggle() {
    const html = document.documentElement;
    const next = html.dataset.theme === 'dark' ? 'light' : 'dark';
    html.dataset.theme = next;
    localStorage.setItem('wb-theme', next);
  },
  init() {
    const saved = localStorage.getItem('wb-theme') || 'light';
    document.documentElement.dataset.theme = saved;
  }
};   

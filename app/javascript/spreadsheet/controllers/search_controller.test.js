import { Application } from 'stimulus'
import SearchController from './search_controller'

describe('SearchController', () => {
  beforeEach(() => {
    // TODO: figurate a way to render view_component instead harcoding html
    document.body.innerHTML = `
      <div class='search hidden'
        data-controller='search'
        data-action='toggle-search@window->search#toggleSearch'
      >
        <input data-search-target='input' />
      </div>
    `;
    const stimulusApp = Application.start();
    stimulusApp.register('search', SearchController);
  });

  describe('#toggleSearch', () => {
    test('show/hide search', () => {
      const searchEl = document.querySelector('.search');
      expect(searchEl.classList.contains('hidden')).toBeTruthy();
      window.dispatchEvent(new CustomEvent('toggle-search'));
      expect(searchEl.classList.contains('hidden')).toBeFalsy();
      window.dispatchEvent(new CustomEvent('toggle-search'));
      expect(searchEl.classList.contains('hidden')).toBeTruthy();
    });

    test('focus input', () => {
      const inputEl = document.querySelector('.search input');
      window.dispatchEvent(new CustomEvent('toggle-search'));
      expect(document.activeElement).toBe(inputEl);
    });
  });
})

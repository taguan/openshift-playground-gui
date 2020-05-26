import { Injectable } from '@angular/core';

/**
 * Simple wrapper class around the window object of the browser
 */
@Injectable()
export class WindowRef {
  get nativeWindow(): any {
    return window;
  }
}

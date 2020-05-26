import { Component } from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {WindowRef} from './windowref';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'gui';

  constructor(private httpClient: HttpClient, private window: WindowRef) {
  }

  createRecord() {
    this.httpClient.post(`${this.window.nativeWindow.restServerUrl}/record`, null).subscribe(() => alert('success'));
  }
}

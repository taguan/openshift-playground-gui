import { Component } from '@angular/core';
import {HttpClient} from '@angular/common/http';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'gui';

  constructor(private httpClient: HttpClient) {
  }

  createRecord() {
    this.httpClient.post('http://localhost:8080/record', null).subscribe(() => alert('success'));
  }
}

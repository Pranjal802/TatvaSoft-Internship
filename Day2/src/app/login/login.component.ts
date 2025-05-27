import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [FormsModule],
  template: `
    <div class="container mt-5">
      <div class="row justify-content-center">
        <div class="col-md-6">
          <div class="card">
            <div class="card-header">
              <h2 class="text-center">Login</h2>
            </div>
            <div class="card-body">
              <form>
                <div class="mb-3">
                  <label for="email" class="form-label">Email address</label>
                  <input type="email" class="form-control" id="email" name="email" [(ngModel)]="email">
                </div>
                <div class="mb-3">
                  <label for="password" class="form-label">Password</label>
                  <input type="password" class="form-control" id="password" name="password" [(ngModel)]="password">
                </div>
                <div class="d-grid">
                  <button type="button" class="btn btn-primary" (click)="login()">Login</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  `,
  styles: [] // Empty styles, as Bootstrap is handled globally
})
export class LoginComponent {
  email = '';
  password = '';

  login() {
    console.log('Email:', this.email);
    console.log('Password:', this.password);
  }
} 
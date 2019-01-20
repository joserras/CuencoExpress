import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { FormControl, FormGroup } from '@angular/forms';
import { ExpressService } from '../express.service';
import { User } from '.././Models/user';
import { Router } from "@angular/router";
import { AuthService, FacebookLoginProvider, GoogleLoginProvider } from 'angular5-social-login';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  profileForm = new FormGroup({
    email: new FormControl(''),
    password: new FormControl(''),
    checkPassword: new FormControl('')
  });
  user: User;
 
  constructor(private expressService: ExpressService, private router: Router, private socialAuthService: AuthService ) {
    this.user = new User();

  }

  ngOnInit() {
    
  }
  onSubmit() {
    var that = this.user;
    this.expressService.getUser(this.profileForm.value.email, this.profileForm.value.password, this.profileForm.value.checkPassword != true ? false : this.profileForm.value.checkPassword ).subscribe(
      response => {
        this.user = response;
        localStorage.setItem('token', response.token);
        localStorage.setItem('tokenExpiration', response.tokenExpiration);
        this.router.navigate(['/']);
      }
    );
    
    console.log(this.user);
  }

  public facebookLogin() {
    let socialPlatformProvider = FacebookLoginProvider.PROVIDER_ID;
    this.socialAuthService.signIn(socialPlatformProvider).then(
      (userData) => {
        
        //this will return user data from facebook. What you need is a user token which you will send it to the server
       // this.sendToRestApiMethod(userData.token);
        this.router.navigate(['/login']);
        console.log(userData);
        let token: any = userData.token;
       
        localStorage.setItem('token', token);
        var date:Date = new Date();
        date.setDate(date.getDate() + 1);
        var tokenExpiration: any = date.toLocaleString();
        localStorage.setItem('tokenExpiration', tokenExpiration);
        this.router.navigate(['/']);
        console.log(userData);
      }
    );
    
    


  }
}

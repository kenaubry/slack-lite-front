import { Component } from '@angular/core';
import { UserService } from 'src/app/services/user';

@Component({
	selector: 'app-main',
	templateUrl: './template.html',
})
export class MainPage {
	constructor(
		// Services
		public userService: UserService
	) {}
}

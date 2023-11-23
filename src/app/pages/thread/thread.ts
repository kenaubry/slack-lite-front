import { Component } from '@angular/core';
import { UserService } from 'src/app/services/user';

@Component({
	selector: 'app-thread',
	templateUrl: './template.html',
	styleUrls: ['./style.css'],
})
export class ThreadPage {
	display: boolean = false;

	constructor(
		// service
		public service: UserService
	) {}

	toggleDisplay() {
		const aside = document.querySelector('aside');
		if (!aside) return;

		this.display = !this.display;
		if (this.display) {
			aside.classList.remove('is-hidden-mobile');
		} else {
			aside.classList.add('is-hidden-mobile');
		}
	}
}

import { Component } from '@angular/core';
import { NgForm } from '@angular/forms';
import { User, UserService } from 'src/app/services/user';

@Component({
	selector: 'app-credential',
	templateUrl: './template.html',
	styleUrls: ['./style.css'],
})
export class CredentialPage {
	name: string = '';

	constructor(private service: UserService) {}

	onSubmit(form: NgForm) {
		const name = form.value.name;
		if (name.length < 1) {
			console.log('bad username');
			return;
		}
		this.service.login(name);
	}

	isLoading() {
		return this.service.loading;
	}
}

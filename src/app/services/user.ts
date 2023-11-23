import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

export interface User {
	id: string;
	name: string;
	avatar: string;
}

@Injectable({
	providedIn: 'root',
})
export class UserService {
	public user: User | null = null;
	public loading: boolean = false;

	constructor(
		// Service
		private http: HttpClient
	) {
		const username = localStorage.getItem('username');
		if (username) {
			this.loading = true;
			this.login(username);
		}
	}

	login(name: string) {
		const url = `/api/v1/users`;
		const request = this.http.post<User>(url, { name });
		request.subscribe(async (user: User) => {
			localStorage.setItem('username', user.name);
			this.user = user;
			this.loading = false;
		});
	}

	logout() {
		localStorage.removeItem('username');
		this.user = null;
	}
}

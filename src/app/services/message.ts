import { Injectable } from '@angular/core';
import { User, UserService } from './user';
import { Thread, ThreadService } from './thread';
import { HttpClient } from '@angular/common/http';

export class Message {
	constructor(
		public id: string,
		public content: string,
		public author: User,
		public date: Date
	) {}
}

export interface ServerMessage {
	id: string;
	content: string;
	author: User;
	date: string;
}

@Injectable({
	providedIn: 'root',
})
export class MessageService {
	messages: Message[] = [];
	loading: boolean = false;
	hasnext: boolean = true;

	constructor(
		// Services
		private userService: UserService,
		private threadService: ThreadService,
		private http: HttpClient
	) {
		threadService.onChange.subscribe((thread: Thread) => {
			this.loading = true;
			this.hasnext = true;
			this.fetch(thread.id);
		});
	}

	fetch(tid: string, offset: number = 0) {
		// @ts-ignore
		const options = new URLSearchParams({
			thread: tid,
			offset,
		});
		const url = `/api/v1/messages?${options}`;
		const request = this.http.get<ServerMessage[]>(url);
		request.subscribe((messages: ServerMessage[]) => {
			if (offset < 1) {
				this.messages = [];
			}
			for (let m of messages) {
				const message = this.serverMessageToMessage(m);
				this.messages.push(message);
			}
			this.sort();
			this.loading = false;
			if (messages.length < 20) {
				this.hasnext = false;
			}
		});
		// TODO : ajouter la gestion des erreurs serveur
	}

	create(content: string) {
		const user = this.userService.user;
		const thread = this.threadService.thread;
		if (!user || !thread) {
			return;
		}
		const url = `/api/v1/messages`;
		const body = { content, thread: thread.id };
		const request = this.http.post<ServerMessage>(url, body, {
			headers: {
				Authorization: user.id,
			},
		});
		request.subscribe((m: ServerMessage) => {
			if (!m.date) {
				m.date = new Date().toString();
			}
			const message = this.serverMessageToMessage(m);
			this.messages.push(message);
		});
		// TODO : ajouter la gestion des erreurs serveur
	}

	delete(id: string) {
		const user = this.userService.user;
		if (!user) {
			return;
		}
		const url = `/api/v1/messages/${id}`;
		const request = this.http.delete<Partial<ServerMessage>>(url, {
			headers: {
				Authorization: user.id,
			},
		});
		request.subscribe((message: Partial<ServerMessage>) => {
			this.messages = this.messages.filter((m) => m.id != message.id);
		});
		// TODO : ajouter la gestion des erreurs serveur
	}

	serverMessageToMessage(m: ServerMessage): Message {
		const { id, content, author, date } = m;
		const message = new Message(id, content, author, new Date(date));
		return message;
	}

	sort() {
		this.messages = this.messages.sort(
			(a, b) => a.date.getTime() - b.date.getTime()
		);
	}
}

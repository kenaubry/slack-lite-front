import { EventEmitter, Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

export class Thread {
	public editMode: boolean = false;

	constructor(
		public id: string,
		public label: string,
		public locked: boolean
	) {}
}

export interface ServerThread {
	id: string;
	label: string;
	locked: boolean;
}

@Injectable({
	providedIn: 'root',
})
export class ThreadService {
	thread?: Thread;
	threads: Thread[] = [];
	onChange: EventEmitter<Thread> = new EventEmitter();

	constructor(
		// Services
		private http: HttpClient
	) {
		this.fetch();
	}

	fetch() {
		const request = this.http.get<ServerThread[]>('/api/v1/threads');
		request.subscribe((threads: ServerThread[]) => {
			this.threads = [];
			for (let { id, label, locked } of threads) {
				this.threads.push(new Thread(id, label, locked));
			}
			this.sort();
		});
		// TODO : gestion erreurs
	}

	change(id: string): boolean {
		const thread = this.threads.find((t) => t.id == id);
		if (thread) {
			this.onChange.emit(thread);
			this.thread = thread;
			return true;
		}
		return false;
	}

	create(label: string) {
		const request = this.http.post<ServerThread>('/api/v1/threads', {
			label,
		});
		request.subscribe((thread: ServerThread) => {
			let { id, label, locked } = thread;
			this.threads.push(new Thread(id, label, locked));
			this.sort();
		});
	}

	update(id: string, label: string) {
		const request = this.http.put<ServerThread>(`/api/v1/threads`, {
			id,
			label,
		});
		request.subscribe((thread: ServerThread) => {
			let { id, label } = thread;
			const th = this.threads.filter((t) => t.id == id)[0];
			th.editMode = false;
			th.label = label;
			this.sort();
		});
	}

	remove(id: string) {
		if (this.thread?.id == id) {
			this.thread = undefined;
		}
		const request = this.http.delete<ServerThread>(`/api/v1/threads/${id}`);
		request.subscribe((thread: ServerThread) => {
			this.threads = this.threads.filter((t) => t.id != thread.id);
		});
	}

	sort() {
		this.threads = this.threads.sort(function (a, b) {
			if (a.locked) return -1;
			if (b.locked) return 1;
			return a.label.localeCompare(b.label);
		});
	}
}

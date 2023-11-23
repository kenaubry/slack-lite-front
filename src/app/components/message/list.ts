import { Component } from '@angular/core';
import { NgForm } from '@angular/forms';
import { MessageService } from 'src/app/services/message';
import { ThreadService } from 'src/app/services/thread';

@Component({
	selector: 'message-list',
	templateUrl: './list.template.html',
	styleUrls: ['./list.style.css'],
})
export class MessageListComponent {
	message!: string;

	constructor(
		// services
		public messageService: MessageService,
		public threadService: ThreadService
	) {}

	// 0: pas de thread choisi, 1: loading, 2: pas de message, 3: des messages
	getState(): number {
		if (!this.threadService.thread) {
			return 0;
		}
		if (this.messageService.loading) {
			return 1;
		}
		if (this.messageService.messages.length < 1) {
			return 2;
		}
		return 3;
	}

	addMessage(form: NgForm) {
		const content = form.value.message;
		this.messageService.create(content);
		form.reset();
	}

	hasMore() {
		return this.messageService.hasnext;
	}

	loadMore() {
		if (!this.threadService.thread) {
			return;
		}
		this.messageService.fetch(
			this.threadService.thread.id,
			this.messageService.messages.length
		);
	}
}

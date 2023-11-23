import { Component, Input } from '@angular/core';
import { Message, MessageService } from 'src/app/services/message';
import { UserService } from 'src/app/services/user';

@Component({
	selector: 'message-item',
	templateUrl: './item.template.html',
	styleUrls: ['./item.style.css'],
})
export class MessageItemComponent {
	@Input() data!: Message;

	constructor(
		// service
		private service: MessageService,
		private userService: UserService
	) {}

	isTheAuthor(): boolean {
		if (this.data.author.id == this.userService.user?.id) {
			return true;
		}
		return false;
	}

	remove() {
		this.service.delete(this.data.id);
	}
}

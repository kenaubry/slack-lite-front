import { Component, Input } from '@angular/core';
import { NgForm } from '@angular/forms';
import { Thread, ThreadService } from 'src/app/services/thread';

@Component({
	selector: 'thread-item',
	templateUrl: './item.template.html',
	styleUrls: ['./item.style.css'],
})
export class ThreadItemComponent {
	@Input() data!: Thread;

	constructor(
		// service
		private service: ThreadService
	) {}

	isSelected() {
		return this.data.id == this.service.thread?.id;
	}

	update(form: NgForm) {
		const id = this.data.id;
		const label = form.value.label;
		this.service.update(id, label);
	}

	toggleEdit(event: MouseEvent) {
		event.stopPropagation();
		this.data.editMode = !this.data.editMode;
	}

	remove(event: MouseEvent) {
		event.stopPropagation();
		this.service.remove(this.data.id);
	}
}

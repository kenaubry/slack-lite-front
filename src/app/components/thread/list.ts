import { Component } from '@angular/core';
import { NgForm } from '@angular/forms';
import { Thread, ThreadService } from 'src/app/services/thread';

@Component({
	selector: 'thread-list',
	templateUrl: './list.template.html',
	styleUrls: ['./list.style.css'],
})
export class ThreadListComponent {
	label!: string;

	constructor(
		// services
		public service: ThreadService
	) {}

	changeTo(thread: Thread) {
		if (thread.editMode) {
			return;
		}
		this.service.change(thread.id);
	}

	onSubmit(form: NgForm) {
		const label = form.value.label;
		// TODO : empecher les ajout de thread sans nom
		this.service.create(label);
		form.reset();
	}
}

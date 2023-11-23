import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
	name: 'friendlyDate',
})
export class FriendlyDatePipe implements PipeTransform {
	private month_fr = [
		'janvier',
		'février',
		'mars',
		'avril',
		'mai',
		'juin',
		'juillet',
		'août',
		'septembre',
		'octobre',
		'novembre',
		'décembre',
	];

	transform(value: Date): string {
		let now: Date = new Date(),
			D = value.getDate(),
			M = value.getMonth(),
			Y = value.getFullYear(),
			H = value.getHours(),
			m = ('0' + value.getMinutes()).slice(-2);

		let buffer: string[] = [];
		if (D != now.getDate()) {
			buffer.push(`le ${D} ${this.month_fr[M]}`);
		}
		if (Y != now.getFullYear()) {
			buffer.push('' + Y);
		}
		buffer.push(`à ${H}H${m}`);

		return buffer.join(' ');
	}
}

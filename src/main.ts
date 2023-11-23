import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';

import { MainModule } from './app/modules/main';

platformBrowserDynamic()
	.bootstrapModule(MainModule)
	.catch((err) => console.error(err));

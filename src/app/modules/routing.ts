import { NgModule } from '@angular/core';
import { ThreadPage } from '../pages/thread/thread';
import { RouterModule, Routes } from '@angular/router';

const routes: Routes = [
	{ path: '', component: ThreadPage },
	{ path: '**', redirectTo: '', pathMatch: 'full' },
];

@NgModule({
	imports: [RouterModule.forRoot(routes)],
	exports: [RouterModule],
})
export class AppRoutingModule {}

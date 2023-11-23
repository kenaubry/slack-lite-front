import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './routing';

import { MainPage } from '../pages/main/main';
import { ThreadPage } from '../pages/thread/thread';
import { FriendlyDatePipe } from '../pipes/friendlyDatePipe';
import { CredentialPage } from '../pages/credential/credential';
import { ThreadListComponent } from '../components/thread/list';
import { ThreadItemComponent } from '../components/thread/item';
import { MessageListComponent } from '../components/message/list';
import { MessageItemComponent } from '../components/message/item';

@NgModule({
	declarations: [
		// Pages
		MainPage,
		ThreadPage,
		CredentialPage,
		// Component
		ThreadItemComponent,
		ThreadListComponent,
		MessageItemComponent,
		MessageListComponent,
		// Pipe
		FriendlyDatePipe,
	],
	imports: [BrowserModule, AppRoutingModule, FormsModule, HttpClientModule],
	providers: [],
	bootstrap: [MainPage],
})
export class MainModule {}

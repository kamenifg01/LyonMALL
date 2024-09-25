import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { RouterModule } from '@angular/router';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';

import { CommonModule } from '@angular/common';

@NgModule({
  declarations: [],
  imports: [
    BrowserModule,
    AppRoutingModule,
    RouterModule.forRoot([]),
    AppComponent,
    CommonModule
  ],
  providers: [],
  bootstrap: []
})
export class AppModule { }


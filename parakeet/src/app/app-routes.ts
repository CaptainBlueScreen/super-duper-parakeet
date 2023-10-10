import { Routes } from '@angular/router';
import { PageNotFoundComponent } from './page-not-found/page-not-found.component';
import { WorkingPageComponent } from './working-page/working-page.component';

export const appRoutes: Routes = [
  { path: '', component: WorkingPageComponent }, 
  {
    path: '**',
    component: PageNotFoundComponent,
  },
]
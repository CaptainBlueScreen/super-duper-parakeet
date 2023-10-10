import { ComponentFixture, TestBed } from '@angular/core/testing';

import { WorkingPageComponent } from './working-page.component';

describe('WorkingPageComponent', () => {
  let component: WorkingPageComponent;
  let fixture: ComponentFixture<WorkingPageComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [WorkingPageComponent]
    });
    fixture = TestBed.createComponent(WorkingPageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

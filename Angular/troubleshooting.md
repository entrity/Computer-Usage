# Troubleshooting Angular
----
> Error from chokidar (/home/markham/proj/Insureio/angular-insureio): Error: ENOSPC: System limit for number of file watchers reached, watch '/home/markham/proj/Insureio/angular-insureio/.editorconfig'
**Solution**
see https://stackoverflow.com/a/65347277/507721
```bash
sudo sysctl -w fs.inotify.max_user_watches=524288
```
Or add the following to `/etc/sysctl.conf`
```
fs.inotify.max_user_watches=524288
```

----
> Argument of type 'boolean' is not assignable to parameter of type

I was probably trying to specify `T<U>` but left off an angle bracket `>`

----
> NullInjectorError: No provider for Compiler

https://stackoverflow.com/questions/47214534/nullinjectorerror-no-provider-for-compiler
Import BrowserModule into my main app module:
```js
import {BrowserModule} from '@angular/platform-browser';
// ...
@NgModule({
  imports: [ BrowserModule ],
  // ...
})
```

If you only see this error during unit testing, see this question: [Error: No provider for Compiler! DI Exception Angular 2 Testing](https://stackoverflow.com/questions/38470128/error-no-provider-for-compiler-di-exception-angular-2-testing)

----
> 'router-outlet' is not a known element

https://stackoverflow.com/questions/44517737/router-outlet-is-not-a-known-element

----
> Invalid provider for the NgModule 'DynamicTestModule'

I'm not sure about this, but n your test file, when you specify `TestBed.configureTestingModule`, does everything in the `providers` array give the `provide` function?

I worked around this by replacing...
```js
TestBed.configureTestingModule({
  providers: [httpClientSpy],
  imports: [HttpClientTestingModule]
});
service = TestBed.inject(UserService);
```
...with...
```js
service = new UserService(httpClientSpy as any);
```

----
> Error: mat-form-field must contain a MatFormFieldControl
https://stackoverflow.com/questions/46705101/mat-form-field-must-contain-a-matformfieldcontrol/46795510#46795510
Doesn't appear to be documented, but `MatInputModule` must be imported.
```js
import { MatInputModule } from '@angular/material/input';
```

----
> NullInjectorError: No provider for MatDialogRef
https://stackoverflow.com/a/53113329/507721


----
> ERROR Error: No value accessor for form control with unspecified name attribute

**Solution:** I had `<mat-form-field [formControl]="originPolicy">`. I didn't have a name attribute on that element. (But that element doesn't need a formControl, so I removed it.)


----
> No provider for InjectionToken MatSnackBarData

**Solution:** This occured in a spec file, so in that file, add:
```js
import { MAT_SNACK_BAR_DATA } from '@angular/material/snack-bar'; // near the top
// ...
  beforeEach(async () => {
    await TestBed.configureTestingModule({
      // ...
      providers: [{ provide: MAT_SNACK_BAR_DATA, useValue: mockData }],
    })
    .compileComponents();
  });
```

----
> Property ... is missing in type ... but required in type ...

**Solution:** I had this for `window` when trying to cast `window as IWindow`, so I changed the cast to `window as any as IWindow`.

----
> Type 'never[]' is not assignable to type 'TaskType[] & TaskTypesMeta'.

**Solution:** Kludge `as any`: `(window as any as IWindow).TaskTypes = [] as any;`

----
> Error: Expected one matching request for criteria "Match URL: $tasks.json", found 3 requests.

----
`<app-root></app-root>` is empty.

**Solution:** Check the Rails server. Is it serving the dependencies?

---
> An unhandled exception occurred: Cannot find module '@angular-devkit/build-angular/package.json'
Run `yarn` to get dependencies installed.

---
Angular is looking for fontawesome at top-level
> GET http://pinney.local.com:4200/fontawesome-webfont.woff2?v=4.7.0 net::ERR_ABORTED 404 (Not Found)
**Solution**
cf. https://stackoverflow.com/a/39557671/507721
- `rm -r node_modules/@fortawesome/`
- `npm install --save font-awesome`
- Add to `styles` array in `angular.json`:
```
"../node_modules/bootstrap/dist/css/bootstrap.css",
"../node_modules/font-awesome/css/font-awesome.css"
```
Don't forget to restart your ng server.

# Angular (typescript)

## Generator
```bash
ng new --routing --strict --style=css
ng generate component messages
ng generate component header/quick-launch
ng generate service message
ng generate module app-routing --flat --module=app
# --flat puts the file in src/app instead of its own folder.
# --module=app tells the CLI to register it in the imports array of the AppModule.
ng g c foo -m app # Shorthand
```

## Build
```bash
# Build default app for prod
ng build --prod --source-map
# Build non-default app
ng build side-project --base-href /side-project/
```

## Building multiple apps in one project:
Refer to building multiple apps in one project:
https://www.tektutorialshub.com/angular/angular-multiple-apps-in-one-project/
```bash
# Optionally, start a project with no principal app
ng new MyWorkspace --createApplication=false
# Generate a new non-main app, which shows up in `projects` instead of `src`
# This also adds data on the app to `angular.json`
ng generate application side-app --routing --strict --style=css
ng generate component my-elem --project=side-app
# Serve the side application
ng serve side-app -o
# Build for production
ng build embeddable-quoters --base-href /embedded/
```
Then provide an **Apache config** to handle the url rewrites:
```
# Main app (ng)
# Only urls that don't end in a file extension
RewriteCond  %{REQUEST_URI} !\.[a-z]+$
RewriteRule ^/consumers/(.*)$ /ng/consumers/$1
# Don't overwrite runtime.js, polyfills.js, vendor.js, main.js, styles.css, etc.
RewriteCond  %{REQUEST_URI} !\.(js|css)$
RewriteRule ^/ng/ /ng/index.html
# Quoter widgets app (embeddable-quoters)
# Only urls that don't end in a file extension
RewriteCond  %{REQUEST_URI} !\.[a-z]+$
RewriteRule ^/quoting/widgets/ /embeddable-quoters/index.html
# Correct /ng/favicon.ico etc
RewriteRule ^/.*/favicon.ico$ /favicon.ico
```

## Serve multiple apps

Refer to Server Configuration and the Base Tag:
* https://angular.io/guide/deployment#server-configuration
* https://angular.io/guide/deployment#the-base-tag

+ The Rails app needs to continue serving at the same domain
+ The Angular app needs to serve at the same domain
+ Customer facing apps need to be lighter-weight than the spa and serve at the same domain

Handle these with rewrites in the Apache config.

## Child routes/Nested routes
https://angular.io/api/router/Route
https://angular.io/guide/router#nesting-routes
https://codecraft.tv/courses/angular/routing/nested-routes/
https://stackblitz.com/edit/angular-router-prefix?file=src/app/app-routing.module.ts
https://stackoverflow.com/a/62854244/507721

```js
const routes: Routes = [
  {
    path: '',
    // pathMatch: 'full',
    children: [
      {
        path: 'foo',
        component: FooComponent
      },
    ],
  },
  {
    path: '**',
    component: NotFoundComponent,
  }
];
```
```html
<h2>First Component</h2>

<nav>
  <ul>
    <li><a routerLink="child-a">Child A</a></li>
    <li><a routerLink="child-b">Child B</a></li>
  </ul>
</nav>

<router-outlet></router-outlet>
```

## Testing
_See Angular/testing.md_

## Devtools
```js
ng.getOwningComponent($0) // grants access to the component (fns, etc)
ng.getContext($0).$implicit // grants access to the current object
ng.getContext($0) // grants access to ngRepeat etc
```

## Set new property on `window`
```js
(globalThis as any).myNewField = myValue;
(window as any).myNewField = myValue;
```

## Element reference in Component class
```html
<some-tag #mytag></some-tag>
```
```js
export class MyComponent implements OnInit {
  @ViewChild('mytag') element?: ElementRef<any>;

  ngAfterViewInit() {
    console.dir('input', this.element);
  }
}
```

## Questions
How can both angular app and rails app be on the same domain name?
Can we use a prefix for the angular app?
  The ng app is deployed to public/ng
  The ng app expects all URL paths to be prefixed with `/ng`
Can we have the angular app's default path make it request info from the rails app?

## Todo (framework)
top nav
left nav
bulletins
multiple apps

## Important things
- `ActivatedRoute` - get current location (url, params)
- `router.navigate` & `router.navigateByUrl`
- [Lazy loading](https://angular.io/guide/lazy-loading-ngmodules#lazy-loading-basics)
- For apps for legacy browsers, use `HashLocationStrategy` instead of `PathLocationStrategy` [link](https://angular.io/guide/router#locationstrategy-and-browser-url-styles)
- Differential builds/loading allows older browsers to request more polyfills without requiring that newer browsers get such a big build. https://angular.io/guide/deployment#differential-loading
- `switchMap((injections) => service.run)` - does two things. It flattens the Observable that its callback returns and cancels previous pending requests. If the user re-navigates to this route with a new id while the HeroService is still retrieving the old id, switchMap discards that old request and returns the hero for the new id.
- `pipe(...)` - chain Observables together. Import from `rxjs/operators`
- `| async` - AsyncPipe
- `BrowserAnimationsModule` - animate transitions between routes
- https://angular.io/guide/forms
- @ContentChild or @ContentChildren
- https://angular.io/guide/template-reference-variables
- autocomplete
    - https://material.angular.io/components/autocomplete/overview
    - https://stackblitz.com/angular/epaooxplrdd?file=src%2Fmain.tshttps://stackblitz.com/angular/epaooxplrdd?file=src%2Fmain.tshttps://stackblitz.com/angular/epaooxplrdd?file=src%2Fmain.ts
- Partial, Required, Pick, Readonly https://www.typescriptlang.org/docs/handbook/utility-types.html


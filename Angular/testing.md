# Angular testing

```bash
ng test
ng e2e # Run e2e tests
# Run for a different config (i.e. build target). https://angular.io/guide/deployment#local-development-in-older-browsers
ng test --configuration es5
```
ng test --help
ng test --watch=false
ng test --no-watch
ng test --include=glob

ng test project-name
ng test --only-changed
ng test --testNamePattern componentnam
ng test --include fileordir

## Testing a service with dependencies
```js
describe('MasterService without Angular testing support', () => {
  let masterService: MasterService;

  it('#getValue should return real value from the real service', () => {
    masterService = new MasterService(new ValueService());
    expect(masterService.getValue()).toBe('real value');
  });

  it('#getValue should return faked value from a fakeService', () => {
    masterService = new MasterService(new FakeValueService());
    expect(masterService.getValue()).toBe('faked service value');
  });

  it('#getValue should return faked value from a fake object', () => {
    const fake =  { getValue: () => 'fake value' };
    masterService = new MasterService(fake as ValueService);
    expect(masterService.getValue()).toBe('fake value');
  });

  it('#getValue should return stubbed value from a spy', () => {
    // create `getValue` spy on an object representing the ValueService
    const valueServiceSpy =
      jasmine.createSpyObj('ValueService', ['getValue']);

    // set the value to return when the `getValue` spy is called.
    const stubValue = 'stub value';
    valueServiceSpy.getValue.and.returnValue(stubValue);

    masterService = new MasterService(valueServiceSpy);

    expect(masterService.getValue())
      .toBe(stubValue, 'service returned stub value');
    expect(valueServiceSpy.getValue.calls.count())
      .toBe(1, 'spy method was called once');
    expect(valueServiceSpy.getValue.calls.mostRecent().returnValue)
      .toBe(stubValue);
  });
});
```

## HttpClient
```js
let httpClientSpy: { get: jasmine.Spy };
let heroService: HeroService;

beforeEach(() => {
  // TODO: spy on other methods too
  httpClientSpy = jasmine.createSpyObj('HttpClient', ['get']);
  heroService = new HeroService(httpClientSpy as any);
});

it('should return expected heroes (HttpClient called once)', () => {
  const expectedHeroes: Hero[] =
    [{ id: 1, name: 'A' }, { id: 2, name: 'B' }];

  httpClientSpy.get.and.returnValue(asyncData(expectedHeroes));

  heroService.getHeroes().subscribe(
    heroes => expect(heroes).toEqual(expectedHeroes, 'expected heroes'),
    fail
  );
  expect(httpClientSpy.get.calls.count()).toBe(1, 'one call');
});

it('should return an error when the server returns a 404', () => {
  const errorResponse = new HttpErrorResponse({
    error: 'test 404 error',
    status: 404, statusText: 'Not Found'
  });

  httpClientSpy.get.and.returnValue(asyncError(errorResponse));

  heroService.getHeroes().subscribe(
    heroes => fail('expected an error, not heroes'),
    error  => expect(error.message).toContain('test 404 error')
  );
});
```

## TestBed
```js
let service: ValueService;

beforeEach(() => {
  TestBed.configureTestingModule({ providers: [ValueService] });
});
it('should use ValueService', () => {
  service = TestBed.inject(ValueService);
  expect(service.getValue()).toBe('real value');
});
```
### TestBed for service with dependencies
```js
let masterService: MasterService;
let valueServiceSpy: jasmine.SpyObj<ValueService>;

beforeEach(() => {
  const spy = jasmine.createSpyObj('ValueService', ['getValue']);

  TestBed.configureTestingModule({
    // Provide both the service-to-test and its (spy) dependency
    providers: [
      MasterService,
      { provide: ValueService, useValue: spy }
    ]
  });
  // Inject both the service-to-test and its (spy) dependency
  masterService = TestBed.inject(MasterService);
  valueServiceSpy = TestBed.inject(ValueService) as jasmine.SpyObj<ValueService>;
});
```
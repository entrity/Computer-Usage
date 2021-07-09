# Rspec

## `and_call_original` from block
```ruby
expect(obj).to receive(:method).and_wrap_original { |orig_method, *args|
  orig_method.call *args
}
```

## Negated matcher (because chaining to_not/not_to is not supported)
```ruby
RSpec::Matchers.define_negated_matcher :not_change, :change
```

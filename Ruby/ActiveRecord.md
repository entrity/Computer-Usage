# ActiveRecord

## Hack: specify non-db attrs for instance
```ruby
values = {'id' => 3, 'foo' => 'bar', 'baz' => 97}
additional_types = User.column_types.slice("id") # Get a Hash
additional_types['foo'] = ActiveRecord::Type::String.new limit: 255
additional_types['baz'] = ActiveRecord::Type::Decimal.new scale: 2, precision: 5
attributes = User.attributes_builder.build_from_database values, additional_types
custom_user = User.allocate.init_with 'attributes' => attributes, 'new_record' => false
```

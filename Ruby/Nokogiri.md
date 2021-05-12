# Nokogiri
Nokogiri is a gem for XML and HTML building/parsing.

## Add to doc
```ruby
b = Nokogiri::XML::Builder.new {|xml|
  xml.root {
    xml.foo('bar')
    xml.wing
  }
}

if froot = b.doc.at('wing')
  f = Nokogiri::XML::Builder.with(froot) do |xml|
    xml.yes 'oy!'
  end
else
  raise RuntimeError.new 'no frrot'
end
```

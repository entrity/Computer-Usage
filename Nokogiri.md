# Nokogiri

**Nokogiri** is a ruby gem for parsing/building XML, HTML.

## Building

`Nokogiri::Builder` is an easy way to build documents

### Namespaces with `Nokogiri::Builder`
```ruby
namespaces = {"xmlns:soapenv" => "http://schemas.xmlsoap.org/soap/envelope/", "xmlns:api" => "http://api.example.com/"}

b = Nokogiri::XML::Builder.new 

b[:soapenv].Envelope(namespaces) {
  b[:soapenv].Body  { 
    b[:api].ClientLogin() {
      b[:api].username('MY_USERNAME')
      b[:api].password('MY_PASSWORD')
      b[:api].applicationKey('MY_APP_KEY')
    }
  }
}
```
Creates:
```xml
<?xml version="1.0"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"xmlns:api="http://api.example.com/">
  <soapenv:Body>
    <api:ClientLogin>
      <api:username>MY_USERNAME</api:username>
      <api:password>MY_PASSWORD</api:password>
      <api:applicationKey>MY_APP_KEY</api:applicationKey>
    </api:ClientLogin>
  </soapenv:Body>
</soapenv:Envelope>
```

## Parsing

### XPath

XPaths are one way to specify elements in an XML document.
* `//` means "search from anywhere"
* `/` means "search from the top"
* A lack of `//` or `/` at the beginning means "search from the current location"

E.g.
```ruby
doc.at_xpath '//Body'
doc.at_xpath '/Envelope/Body'
doc.at_xpath('/Envelope').at_xpath('Body')
```

* `at_xpath` returns the first match
* `xpath` returns an array of matches

### Namespaces
```ruby
# Just remove all namespaces
doc.remove_namespaces!
# Access using xpath where SOAP-ENV is the namespace
doc.at_xpath '//SOAP-ENV:Body'
```

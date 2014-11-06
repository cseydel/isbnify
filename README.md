isbnify
=======

[![isbnify API Documentation](https://www.omniref.com/ruby/gems/isbnify.png)](https://www.omniref.com/ruby/gems/isbnify)

hyphenate, verify and create ISBN13 numbers

### Functionality
* creates valid ISBN13 fake numbers, allready hyphinated
* check ISBN13 validity of a given number
* hyphinate valid ISBN13 number


### Implementation
Include Isbnify into your controller and use the helper actions or call object Isbnify::ISBN class actions.


### Functions

``create_isbn`` or ``Isbnify::ISBN.create_isbn``

Returns a random, yet valid fake ISBN allready hyphinated.

``hyphinate_isbn(String)`` or ``Isbnify::ISBN.hyphinate_isbn(String)``

Returns hyphinated ISBN or error message as String.

``valid_isbn?(String)`` or ``Isbnify::ISBN.valid_isbn?(String)``

Returns true or false, whether a given ISBN is valid or not. It can be passed as hyphinated ISBN or not.


### Useable method calls

```
class ApplicationController < ActionController
  include Isbnify

  def some_method
    hyphinate_isbn("9783404166695")               # returns "978-3-404-16669-5"
    Isbnify::ISBN.hyphinate_isbn("9783404166695") # returns "978-3-404-16669-5"
  end

  def some_other_method
    valid_isbn?("9783404166695")                  # returns true
    Isbnify::ISBN.valid_isbn?("9783404166695")    # returns true
  end

  def some_last_method
    create_isbn                       # returns random well-formed isbn number
    Isbnify::ISBN.create_isbn         # returns random well-formed isbn number
  end

end
```

### Ruby Versions

This gem was developed and tested with versions 1.9.3 and 2.0.0

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

### Copyright

Copyright (c) 2014 Christoph Seydel. See LICENSE for further details.
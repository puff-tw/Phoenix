# Phoenix ERP



### To-do:

* Orders section needs some love. It was a low business priority and hence, even though there is a model and code hanging around, it may not be working properly.
* Move admin panel to core app and get rid of Rails Admin and CanCanCan gems. Rails Admin is good to use during initial phases of the App.
* Remove hard-coded values in code which were used for interim use during live events. Once multi-location operations is enabled, user authorisation should define access.

## Contributing

1. Fork it ( http://github.com/goravbhootra/Phoenix/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Changes Made
1. Added Onhand and total sales summary report(botn inline and excel)
2. Added Popup on negatie sales 
3. Added individual search filter for every grid in column itself
4. Added Voucher based search in total sales report itself.
4. Changed Language into products in total sales summary screen

# Credits

This project is built by [Team Solutionize](http://solutionize.in/). Members who actively contributed to the project: Gorav Bhootra, Chandrasekhar N., Vasumathi N.


# License

Phoenix ERP is released under the [GPL v3](http://www.gnu.org/licenses/quick-guide-gplv3.html)

#script for Threshold

```sql

CREATE TABLE threshold_captures
(
  id SERIAL PRIMARY KEY NOT NULL,
  category_id INT,
  language_id INT,
  product_sku INT,
  threshold_value INT
);

CREATE TABLE thresholds
(
  id SERIAL PRIMARY KEY NOT NULL,
  sku INT,
  threshold_val INT DEFAULT 5,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL
);


```
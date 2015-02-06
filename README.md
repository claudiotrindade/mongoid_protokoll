# MongoidProtokoll

This is another version of gem 'protokoll' for mongoid. For more information access the link : https://github.com/celsodantas/protokoll

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mongoid_protokoll'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongoid_protokoll

## Usage

```ruby
 # creating an autoincrement column based on Time
class Call 
	include Mongoid::Document
	include Mongoid::Protokoll
	protokoll :registry_number  # by default it uses "%Y%m#####"
end

Time.local(2011)
call01 = Call.create
call01.registry_number
=> "201100001"

call02 = Call.create
call02.registry_number
=> "201100002"

Time.local(2012)

call03 = Call.create
call03.registry_number
=> "201200001"  # restarts counter because it is the first item of the year
```

If you want to use your own pattern, just do this:

```ruby
class Call
	include Mongoid::Document
	include Mongoid::Protokoll
    protokoll :registry_number, :pattern => "some#####thing"
end

# this will produce
call01 = Call.create
call01.registry_number
=> "some00001thing"

call02 = Call.create
call02.registry_number
=> "some00002thing"
```

Or use any time based format. You can use in the pattern any combination of:

```ruby
# assume it's 2011/01/01 12:00
"%Y" for year   	# => appends 2011 
"%y" for year   	# => appends 11 
"%m" for month  	# => appends 01
"%d" for day	 	# => appends 01
"%H" for hour	 	# => appends 12
"%M" for minute 	# => appends 00
"#"  for the autoincrement number (use and long as you want)
```

Using the Time formating string ("%y", "%m", ...) is totally optional. It's fine to use "CALL####", "BUY###N" or any combination you like.

Ex:
```ruby
# :number must be a String
class Car
	include Mongoid::Document
	include Mongoid::Protokoll
    protokoll :number, :pattern => "CAR%y#####"
end

# will produce => "CAR1100001", "CAR1100002"... 

# :sell_number must be a String
class House
	include Mongoid::Document
	include Mongoid::Protokoll
    protokoll :sell_number, :pattern => "%YHOUSE#####"
end

# will produce => "2011HOUSE00001", "2011HOUSE00002"...
```

## reserve_number!

   object.reserve_number!

Add a new intance method colled: "your_instance#reserve_#{column_name}!".
With it you can reserve a number without the need to save it to the database. Ex:

```ruby
 car = Car.new
 car.number
 # => nil
 car.reserve_number!
 car.number
 # => "CAR1100001"
 # if you save it, the object will preserve the number: "CAR1100001"
```

It just increases the counter so any other object that gets saved or uses the #reserve_#{column_name} will get the next available number.


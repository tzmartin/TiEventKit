# tieventkit Module

## Description

Ti.EventKit brings in iOS EventKit into the Titanium namespace.  You can add events to iOS apps using the native calendar app.
The compiled module zip file is available in the /dist folder.

## Accessing the tieventkit Module

To access this module from JavaScript, you would do the following:

	  Titanium.event = require('ti.eventkit');

The Titanium.event variable is a reference to the Module object.	Alternatively you can instantiate the module into a separate variable:
  
    var tieventkit = require('ti.eventkit');

## Reference

Note: You'll need to pass the times based on the 24 hour clock, pre-adjusted to UTC to get the expected results.

### ti.eventkit.function

    newEvent(START_DATE, END_DATE, TITLE,LOCATION, NOTE);

### ti.eventkit.property

None.

## Usage

```
    Titanium.event = require('ti.eventkit');
    var results = Titanium.event.newEvent('2011-05-18 01:30:00 GMT','2011-05-18 05:00:00 GMT','Scotts BDay!','Our house','If this works, say W00t!');
    Titanium.API.log(results);

    // Returns
    [OBJ-C] arg1 is: 2011-05-18 01:30:00 GMT
    [OBJ-C] arg2 is: 2011-05-18 05:00:00 GMT
    [OBJ-C] arg3 is: Scotts BDay!
    [OBJ-C] arg4 is: Our house
    [OBJ-C] arg5 is: If this works, say W00t!
```

## Author

Terry Martin
http://twitter.com/tzmartin

Mark Pemburn
http://developer.appcelerator.com/user/831551/mark-pemburn

## License

This content is released under the  MIT License.
http://www.opensource.org/licenses/mit-license.php

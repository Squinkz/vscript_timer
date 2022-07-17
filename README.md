# CS:GO VScript Timer Module
This is a simple class to implement a basic timer. It does not rely on any entities and uses only Server Time, which theoretically should mean it's accurate at all tickrates, and does not break at high tickrates.
As well being a basic timer, you can also just use it to convert Server Time (which is returned in seconds) to hours, minutes, seconds and milliseconds, in float format or string format.

## Usage
#### Basic Usage
To use the timer functions, first initialize a variable to store the timer:

```javascript
myTimer <- Timer();
```

Then to start the timer, call Start() and to end the timer, call End(). After that you can retrieve the elapsed time with GetTime()

```javascript
myTimer.Start();
```
```javascript
myTimer.End();
local myElapsedTime = myTimer.GetTime());	// returns an array of float values
											// index 0 = hours
											// index 1 = minutes
											// index 2 = seconds
											// index 3 = milliseconds
```
*note: both Start() and End() also return time values in seconds, might be useful for debugging*
#### Getting the elapsed time as a string
Alternatively, if you wanted the output in string format, you can use GetTimeString () with the first parameter being an optional choice of delimiter (default is ":")
```javascript
printl (myTimer.GetTimeString());		// prints a string in the format "(h)h:mm:ss:msmsms"
printl (myTimer.GetTimeString("-"));	// prints a string in the format "(h)h-mm-ss-msmsms"
```
#### Notes
You do *not* have to call End() to call GetTime() or GetTimeStr(). This can be useful for creating a stopwatch or clock with visual feedback - simply start the timer and call GetTime() every frame to update the clock.

*note: Start() needs to be called before calling End(), GetTime() or GetTimeString()*
#### Resetting the Timer
The Timer can be reset by either calling Start() or Reset():
```javascript
myTimer.Start();	// restarts the timer called myTimer. Started() will return true.
myTimer.Reset();	// completely resets the timer. Started() will return false.
```
There should be no practical difference between the two functions. Use either at your own discretion.
#### Converting seconds
Besides being a timer module, this module is also useful for converting between seconds and all other times (hours, minutes, seconds, milliseconds)
You can use the GetTime() and GetTimeString() functions to do this, as they accept an optional time parameter:
```javascript
local time = myTimer.GetTime (5616.357);	// returns an array of float values
											// index 0 = hours
											// index 1 = minutes
											// index 2 = seconds
											// index 3 = milliseconds
```
```javascript
printl (myTimer.GetTimeString (":", 5616.357)); // prints a string in the format "(h)h:mm:ss:msmsms"
```
#### Get Functions
The following functions are also available, and might be useful:
```javascript
float GetHours ();			// amount of hours that have passed
float GetMinutes ();		// amount of minutes that have passed
float GetSeconds ();		// amount of seconds that have passed
float GetMs();				// amount of milliseconds that have passed

float GetMinutesTotal ();	// total amount of minutes that have passed
float GetSecondsTotal ();	// total amount of seconds that have passed
float GetMsTotal ();		// total amount of milliseconds that have passed

bool Started ();			// whether the timer has been started
bool Running ();			// whether the timer is currently running (has not been ended with End() or Reset()
```

## Credits
Dieter "Squink" Stassen
## License
This code is licensed under the  **WTFPL** license. This means you're allowed to do whatever the hell you want with it.

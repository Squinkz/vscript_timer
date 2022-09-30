
# CS:GO VScript Timer Module
This is a simple class to implement a basic timer. It does not rely on any entities and uses only the server's time, which means it's accurate at all tickrates. It is also very cheap - you can create tens of thousands of timers with no performance impact.

As well being a basic timer, it can also be used to convert Server Time (which is returned in seconds as a float) to hours, minutes, seconds and milliseconds, as an array of integers or a formatted string.

## Usage
#### Start and Stop
To use the timer functions, first initialize a variable to store the timer:

```javascript
myTimer <- Timer();		// create a new timer and store it in a variable called myTimer
```

Then to start the timer, call Start() and to stop the timer, call Stop(). After that you can retrieve the elapsed time with GetTime(). You can also call GetTime() at any point after starting the timer to retrieve the elapsed time.
*(Which means in practice, Stop() and Pause() behave almost the same, except after calling Stop(), the timer cannot be resumed.)*
Passing in a float as an argument to Start will set a maximum time for the timer, after which Expired() will return true.

```javascript
myTimer.Start();				// start counting indefinitely
```
```javascript
myTimer.Stop();					// stop counting
local myElapsedTime = myTimer.GetTime();	// returns an array of integer values
						// index 0 = hours
						// index 1 = minutes
						// index 2 = seconds
						// index 3 = milliseconds
```
```javascript
myTimer.Start(30.0);				// start a timer that lasts for 30 seconds
```
Example Think function:
```javascript
function Think()
{
	UpdateClockEntities(myTimer.GetTime());		// get the time and update in game clock entities

	if (myTimer.Expired())				// call the function DoSomething when the timer has expired
		DoSomething();
		
	return FrameTime();
}
```
#### Pausing and Resuming
To pause a timer, use the Pause() function and call Resume() when you're ready to begin again. The time spent paused will not count towards the total elapsed time.
```javascript
myTimer.Pause();		// pauses the timer called myTimer
```
```javascript
myTimer.Resume();		// resumes the timer called myTimer
```
*notes:*
* Start() always needs to be called before calling Stop(), Pause(), GetTime() or GetTimeString()
* Pause() always needs to be called before Resume()
* The functions Start(), Stop(), Pause() and Resume() also return raw server time in seconds, which might be useful for debugging.
#### Getting the elapsed time as a formatted string
Alternatively, if you want to get the elapsed time as a formatted string, you can use the GetTimeString() function, with the first parameter being an optional choice of delimiter (default is ":").
```javascript
printl (myTimer.GetTimeString());	// prints a string in the format "(h)h:mm:ss:msmsms"
printl (myTimer.GetTimeString("."));	// prints a string in the format "(h)h.mm.ss.msmsms"
printl (myTimer.GetTimeString("-"));	// prints a string in the format "(h)h-mm-ss-msmsms"
```
#### Resetting the Timer
The Timer can be reset by either calling Start() or Reset():
```javascript
myTimer.Start();	// resets and restarts the timer called myTimer. Started() will return true.
myTimer.Reset();	// resets the timer called myTimer. Started() will return false.
```
#### Converting seconds
Besides being a timer module, this module is also useful for converting from seconds to other time units (hours, minutes, seconds, milliseconds).
You can use the GetTime() and GetTimeString() functions to do this, as they accept an optional time parameter:
```javascript
local time = myTimer.GetTime (5616.357);	// returns an array of integer values
						// index 0 = hours 		(1)
						// index 1 = minutes		(33)
						// index 2 = seconds		(36)
						// index 3 = milliseconds	(357)
```
```javascript
printl (myTimer.GetTimeString (":", 5616.357)); // prints a string in the format "1:33:36:357"
```
#### Notes
* You do *not* have to call Stop() to call GetTime() or GetTimeString(). This can be useful for creating a stopwatch or clock with visual feedback - simply start the timer and call GetTime() every frame to update the clock.

* It's also possible to use Stop() to capture the elapsed time at any moment, as the counter does not stop counting when Stop() is called.
Only the elapsed time from when Start() was called and the last time Stop() was called will be returned with GetTime() and GetTimeString() though.
*(or the time from Start() to the current time if Stop() has not been called.)*
#### Get Functions
The following functions are also available, and might be useful:
```javascript
float GetHours()		// number of hours that have passed
float GetMinutes()		// number of minutes that have passed
float GetSeconds()		// number of seconds that have passed
float GetMs()			// number of milliseconds that have passed

float GetMinutesTotal()		// total number of minutes that have passed
float GetSecondsTotal()		// total number of seconds that have passed
float GetMsTotal()		// total number of milliseconds that have passed

float GetStartTime()		// returns an array of the server time when the timer started (similar to GetTime)
float GetEndTime()		// returns an array of the server time when the timer stopped
				// (or the current time, if the timer has not stopped)

bool Started()			// whether the timer has been started
bool Running()			// whether the timer is currently running (has not been stopped with Stop() or Reset())
bool Paused()			// whether the timer is currently paused
```

## Credits
Dieter "Squink" Stassen
## License
This code is licensed under the  **WTFPL** license. This means you're allowed to do whatever the hell you want with it.

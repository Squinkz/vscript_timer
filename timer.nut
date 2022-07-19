///////////////////////////////////////////////////////////////////
//---------------------------------------------------------------//
//-------------------Basic Timer Module-v2.2---------------------//
//---------------------------------------------------------------//
//----  Author:    Dieter "Squink" Stassen                   ----//
//----  License:   WTFPL                                     ----//
//----  GitHub:    https://github.com/Squinkz/vscript_timer  ----//
//---------------------------------------------------------------//
//---------------------------------------------------------------//
///////////////////////////////////////////////////////////////////

class Timer
{
	startTime = null;
	endTime = null;
	started = null;
	running = null;
	paused = null;

	constructor ()
	{
		startTime = 0.0;
		endTime = 0.0;
		started = false;
		running = false;
		paused = null;
	}

	function Reset ()
	{
		this.startTime = 0.0;
		this.endTime = 0.0;
		this.started = false;
		this.running = false;
		this.paused = null;

		if (GetDeveloperLevel())
			printl ("Timer reset");
	}

	function Start ()
	{
		this.Reset();
		this.startTime = Time();
		this.started = true;
		this.running = true;
		this.paused = false;

		if (GetDeveloperLevel())
			printl ("Timer started at " + this.startTime);

		return this.startTime;
	}

	function Pause ()
	{
		if (!this.started || !this.running)
		{
			printl ("Timer class: Pause() error - Timer has not started yet.");
			return;
		}
		if (this.paused)
		{
			printl ("Timer class: Pause() error - Timer is already paused.");
			return;
		}

		this.endTime = Time();
		this.paused = true;

		if (GetDeveloperLevel())
			printl ("Timer paused at " + this.endTime);

		return this.endTime;
	}

	function Resume ()
	{
		if (!this.paused)
		{
			printl ("Timer class: Resume() error - Timer is not paused");
			return;
		}

		local resumeTime = Time();
		this.startTime = resumeTime - (this.endTime - this.startTime);
		this.endTime = 0.0;
		this.paused = false;

		if (GetDeveloperLevel())
			printl ("Timer resumed at " + resumeTime);

		return resumeTime;
	}

	function Stop ()
	{
		if (!this.started)
		{
			printl ("Timer class: Stop() error - Timer has not started yet.");
			return;
		}

		if (this.paused)
			this.Resume();

		this.endTime = Time();
		this.running = false;
		this.paused = false;

		if (GetDeveloperLevel())
			printl ("Timer ended at " + this.endTime);

		return this.endTime;
	}

	function GetTime (_time = null)
	{
		local timeArr = array(4, 0.0);

		if (!_time && !this.started)
		{
			printl ("Timer class: GetTime() error - Timer has not started yet.");
			return timeArr;
		}

		local _endTime = this.endTime ? this.endTime : Time();

		local time = null;
		if (_time)
			time = _time;
		else
			time = _endTime - this.startTime;

		local secs = floor(time);
		local hours = floor(secs / 3600);
		local mins = floor(secs / 60);
		local msecs = floor((time - secs) * 1000);
		secs -= mins * 60;
		mins -= hours * 60;

		timeArr[0] = hours;
		timeArr[1] = mins;
		timeArr[2] = secs;
		timeArr[3] = msecs;

		return timeArr;
	}

	function GetStartTime ()
	{
		if (!this.startTime)
		{
			printl ("Timer class: GetStartTime() error - Timer has not started yet.");
			return array(4, 0.0);
		}
		return this.GetTime(this.startTime);
	}

	function GetEndTime ()
	{
		if (!this.startTime)
		{
			printl ("Timer class: GetEndTime() error - Timer has not started yet.");
			return array(4, 0.0);
		}
		if (!this.endTime)
		{
			printl ("Timer class: GetEndTime() error - Timer has not ended yet. Returning current time.");
			return this.GetTime(Time());
		}

		return this.GetTime(this.endTime);
	}

	function GetTimeString (_dlmtr = ":", _time = null)
	{
		local time = this.GetTime(_time);

		local msecStr = "";
		if (time[3] < 10)
			msecStr = "00";
		else if (time[3] < 100)
			msecStr = "0";
		msecStr += "" + time[3];

		local secStr = "";
		if (time[2] < 10)
			secStr = "0";
		secStr += "" + time[2];

		local minStr = "";
		if (time[1] < 10)
			minStr = "0";
		minStr += "" + time[1];

		return "" + time[0] + _dlmtr + minStr + _dlmtr + secStr + _dlmtr + msecStr;
	}

	// Individual Getters
	function GetHours ()
	{
		local time = this.GetTime();
		return time[0];
	}

	function GetMinutes ()
	{
		local time = this.GetTime();
		return time[1];
	}

	function GetSeconds ()
	{
		local time = this.GetTime();
		return time[2];
	}

	function GetMs ()
	{
		local time = this.GetTime();
		return time[3];
	}

	// Totals
	function GetMinutesTotal ()
	{
		local time = this.GetTime();
		local mins = (time[0] * 60) + time[1];
		return mins;
	}

	function GetSecondsTotal ()
	{
		local time = this.GetTime();
		local secs = (((time[0] * 60) + time[1]) * 60) + time[2];
		return secs;
	}

	function GetMsTotal ()
	{
		local time = this.GetTime();
		local msecs = (((((time[0] * 60) + time[1]) * 60) + time[2]) * 1000) + time[3];
		return msecs;
	}

	// Bools
	function Started ()
	{
		return this.started;
	}

	function Running ()
	{
		return this.running;
	}

	function Paused ()
	{
		return this.paused;
	}
}
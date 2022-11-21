--[[
    ___                      ___           ___                       ___           ___     
   /  /\       ___          /__/\         /  /\          ___        /  /\         /  /\    
  /  /:/      /  /\        |  |::\       /  /:/_        /  /\      /  /:/_       /  /::\   
 /__/::\     /  /:/        |  |:|:\     /  /:/ /\      /  /:/     /  /:/ /\     /  /:/\:\  
 \__\/\:\   /__/::\      __|__|:|\:\   /  /:/ /::\    /  /:/     /  /:/ /:/_   /  /:/~/:/  
    \  \:\  \__\/\:\__  /__/::::| \:\ /__/:/ /:/\:\  /  /::\    /__/:/ /:/ /\ /__/:/ /:/___
     \__\:\    \  \:\/\ \  \:\~~\__\/ \  \:\/:/~/:/ /__/:/\:\   \  \:\/:/ /:/ \  \:\/:::::/
     /  /:/     \__\::/  \  \:\        \  \::/ /:/  \__\/  \:\   \  \::/ /:/   \  \::/~~~~ 
    /__/:/      /__/:/    \  \:\        \__\/ /:/        \  \:\   \  \:\/:/     \  \:\     
    \__\/       \__\/      \  \:\         /__/:/          \__\/    \  \::/       \  \:\    
                            \__\/         \__\/                     \__\/         \__\/    

]]--



local subject = script.Parent -- IF THE TEXT LABEL IS SOMEWHERE ELSE, PUT THE DIRECTORY THERE (ignore if you're using Output instead of Label)



--YOUR SETTINGS ARE RIGHT HERE
local config = {
	OutputOrLabel = "Output"; --"Output" or "Label", case sensitive
	refreshRate = 1; --How long should the script take to refresh

	prefix = ":"; --This is what will go between the numbers, ex: 1x30x22pm would have the prefix "x"

	ShowPmAndAm = "Both"; --Should it show PM, AM, Both, or None. (options; PM, AM, Both, None)
	CapsOrLowercaseOrBoth = "lowercase"; -- Should it show PM and AM in lowercase letters, uppercase letters, or both (Both would be like Am or Pm)

	zeroBeforeHour = true; --If the hour is under 10, should it show a 0 before it (ex:true 05:30:22 | ex:false 5:30:22)

	showSeconds = true;
	showMinutes = true;
	showHours = true; 

	TwelveHourClock = true; --Use 12 hour clock

}
--END OF SETTINGS


while true do 	
	wait(config.refreshRate)

	local t2 = {
		s = os.date("*t").sec; 
		m = os.date("*t").min;
		h = os.date("*t").hour;
	}

	local t = {
		s = os.date("*t").sec; 
		m = os.date("*t").min;
		h = os.date("*t").hour;

		meridiem = " "
	}

	if config.TwelveHourClock == false then 
		if config.zeroBeforeHour == true then 
			if t.h<10 then 
				if t.h >12 then 
					t.h = ("0".. t.h-12)
				else
					t.h = ("0".. t.h)
				end
			end
		elseif config.zeroBeforeHour == false then
			if t.h<10 then 
				if t.h >12 then 
					t.h = (t.h-12)
				else
					t.h = (t.h)
				end
			end
		else
			warn("timeScript: config.zeroBeforeHour is not set up correctly.")
		end
	elseif config.TwelveHourClock == true then 
		if t.h >12 then 
			t.h = (t.h-12)
		end
	else
		warn("timeScript: config.TwelveHourClock is not set up correctly.")
	end

	if t.m<10 then 
		t.m = ("0".. t.m)
	elseif t.m>10 then 
		t.m = t.m
	end

	if t.s<10 then 
		t.s = ("0".. t.s)
	elseif t.s>10 then 
		t.s = t.s
	end

	if config.ShowPmAndAm == "PM" then 
		if t2.h>12 then
			if config.CapsOrLowercaseOrBoth == "lowercase" then
				t.meridiem = "pm"
			elseif config.CapsOrLowercaseOrBoth == "uppercase" then
				t.meridiem = "PM"
			elseif config.CapsOrLowercaseOrBoth == "both" then
				t.meridiem = "Pm"
			end
		end
	end

	if config.ShowPmAndAm == "AM" then 
		if t2.h<12 then
			if config.CapsOrLowercaseOrBoth == "lowercase" then
				t.meridiem = "am"
			elseif config.CapsOrLowercaseOrBoth == "uppercase" then
				t.meridiem = "AM"
			elseif config.CapsOrLowercaseOrBoth == "both" then
				t.meridiem = "Am"
			end
		end
	end

	if config.ShowPmAndAm == "Both" then 
		if t2.h>12 then
			if config.CapsOrLowercaseOrBoth == "lowercase" then
				t.meridiem = "pm"
			elseif config.CapsOrLowercaseOrBoth == "uppercase" then
				t.meridiem = "PM"
			elseif config.CapsOrLowercaseOrBoth == "both" then
				t.meridiem = "Pm"
			end
		end
		if t2.h<12 then
			if config.CapsOrLowercaseOrBoth == "lowercase" then
				t.meridiem = "am"
			elseif config.CapsOrLowercaseOrBoth == "uppercase" then
				t.meridiem = "AM"
			elseif config.CapsOrLowercaseOrBoth == "both" then
				t.meridiem = "Am"
			end
		end
	end
	
	if config.TwelveHourClock == true then
		if config.zeroBeforeHour == true then 
			if t.h<10 then 
				t.h = ("0".. t.h)
			end
		end
	end
	
	
	if config.OutputOrLabel == "Label" then
		if config.showHours == true then 
			if config.showMinutes == true then 
				if config.showSeconds == true then
					subject.Text = (t.h .. config.prefix .. t.m .. config.prefix .. t.s .. t.meridiem)
				end
			end
		end
		if config.showHours == true then 
			if config.showMinutes == true then 
				if config.showSeconds == false then
					subject.Text = (t.h .. config.prefix .. t.m .. t.meridiem)
				end
			end
		end
		if config.showHours == true then 
			if config.showMinutes == false then 
				if config.showSeconds == true then
					subject.Text = (t.h .. config.prefix .. t.s .. t.meridiem)
				end
			end
		end
		if config.showHours == true then 
			if config.showMinutes == false then 
				if config.showSeconds == false then
					subject.Text = (t.h .. t.meridiem)
				end
			end
		end
		if config.showHours == false then 
			if config.showMinutes == true then 
				if config.showSeconds == true then
					subject.Text = (t.m .. config.prefix .. t.s .. t.meridiem)
				end
			end
		end
		if config.showHours == false then 
			if config.showMinutes == true then 
				if config.showSeconds == false then
					subject.Text = (t.m .. t.meridiem)
				end
			end
		end
		if config.showHours == false then 
			if config.showMinutes == false then 
				if config.showSeconds == true then
					subject.Text = (t.s .. t.meridiem)
				end
			end
		end
		if config.showHours == false then 
			if config.showMinutes == false then 
				if config.showSeconds == false then
					subject.Text = "Please check Output, or go to line 223 of the script to ignore" --IF YOU WOULD LINE TO IGNORE THIS, JUST DELETE THIS LINE
					warn("config.showHours, config.showMinutes, config.showSeconds are all disabled; Please enable one to show time")
				end
			end
		end
	end

	if config.OutputOrLabel == "Output" then
		if config.showHours == true then 
			if config.showMinutes == true then 
				if config.showSeconds == true then
					print(t.h .. config.prefix .. t.m .. config.prefix .. t.s .. t.meridiem)
				end
			end
		end
		if config.showHours == true then 
			if config.showMinutes == true then 
				if config.showSeconds == false then
					print(t.h .. config.prefix .. t.m .. t.meridiem)
				end
			end
		end
		if config.showHours == true then 
			if config.showMinutes == false then 
				if config.showSeconds == true then
					print(t.h .. config.prefix .. t.s .. t.meridiem)
				end
			end
		end
		if config.showHours == true then 
			if config.showMinutes == false then 
				if config.showSeconds == false then
					print(t.h .. t.meridiem)
				end
			end
		end
		if config.showHours == false then 
			if config.showMinutes == true then 
				if config.showSeconds == true then
					print(t.m .. config.prefix .. t.s .. t.meridiem)
				end
			end
		end
		if config.showHours == false then 
			if config.showMinutes == true then 
				if config.showSeconds == false then
					print(t.m .. t.meridiem)
				end
			end
		end
		if config.showHours == false then 
			if config.showMinutes == false then 
				if config.showSeconds == true then
					print(t.s .. t.meridiem)
				end
			end
		end
		if config.showHours == false then 
			if config.showMinutes == false then 
				if config.showSeconds == false then
					warn("config.showHours, config.showMinutes, config.showSeconds are all disabled; Please enable one to show time")
				end
			end
		end
	end
end

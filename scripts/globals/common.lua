-----------------------------------
--  switch
-----------------------------------

function switch(c)
    local swtbl = {
        casevar = c,
        caseof = function(self, code)
            local f
            if (self.casevar) then
                f = code[self.casevar] or code.default
            else
                f = code.missing or code.default
            end
            if (f) then
                if (type(f) == "function") then
                    return f(self.casevar, self)
                else
                    error("case "..tostring(self.casevar).." not a function")
                end
            end
        end
    }
    return swtbl
end

-----------------------------------
--  printf
-----------------------------------

function printf(s, ...)
    print(s:format(...))
end

-----------------------------------
--  set()
--  Returns a set that can be checked against
-----------------------------------
function set(list)
    local set = {}
    for _, item in pairs(list) do
        set[item] = true
    end
    return set
end

-----------------------------------
--  getMidnight
--  Returns midnight for the current day in epoch format
-----------------------------------

function getMidnight(day)
    -- Get time, because this is going to get ugly.  Using ! for UTC won't work where we're going.
    local hometime = os.date("*t")
    if day ~= nil then
        hometime = os.date("*t", day)
    end
    -- Set to 24:00 to get end of the day.
    local midnight = os.time{year=hometime.year, month=hometime.month, day=hometime.day, hour=24}
    -- And determine the timezone in seconds, because we'll need that to get UTC and LUA doesn't make it easy.
    local timezone = os.difftime(os.time(), os.time(os.date("!*t")))

    -- Midnight adjusted for timezone, then timezone offset * 3600 to get us where we want to be.
    local finaltime = midnight + timezone - (TIMEZONE_OFFSET * 3600)
    -- And make sure that the offset midnight isn't already passed
    if day ~= nil and finaltime <= day or day == nil and finaltime <= os.time() then
        finaltime = finaltime + 86400
    end

    return finaltime
end

-----------------------------------
--  getVanaMidnight(day)
--  Returns earth time value for midnight for current (or supplied day) in epoch format
-----------------------------------

function getVanaMidnight(day)
    local curtime = os.time()
    if day ~= nil then
        curtime = curtime + 24 * 144 * day
    end
    local finaltime = curtime + (23-VanadielHour())* 144 + (60-VanadielMinute())*2.4
    return finaltime
end

-----------------------------------
--  getConquestTally()
--  Returns the end of the current conquest tally
-----------------------------------

function getConquestTally()
    -- Get time into a handy dandy table
    local weekDayNumber = tonumber(os.date("%w"))
    local daysToTally = 0
    -- LUA is Sun -> Sat, conquest is Mon -> Sun, so adjustments via conditional are needed.
    -- If today is Sunday (0), no additional days are necessary, so keep the 0.
    -- Ex: Friday = 5, 7 - 5 = 2 days to add, all of Saturday and Sunday.
    if weekDayNumber > 0 then
        daysToTally = 7 - weekDayNumber
    end

    -- Midnight + daysToTally * a day worth of seconds.
    return getMidnight() + daysToTally * 86400
end

-----------------------------------
--  vanaDay()
--  Small function to make it easier to store the current date
-----------------------------------
function vanaDay()
    return VanadielYear() * 360 + VanadielDayOfTheYear()
end

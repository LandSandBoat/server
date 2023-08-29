-----------------------------------
--  switch
-----------------------------------

function switch(c)
    local swtbl =
    {
        casevar = c,
        caseof = function(self, code)
            local f
            if self.casevar then
                f = code[self.casevar] or code.default
            else
                f = code.missing or code.default
            end

            if f then
                if type(f) == 'function' then
                    return f(self.casevar, self)
                else
                    error('case '..tostring(self.casevar)..' not a function')
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
--  Returns the next upcoming JST midnight
-----------------------------------

getMidnight = JstMidnight

-----------------------------------
--  getVanaMidnight(day)
--  Returns earth time value for midnight for current (or supplied day) in epoch format
-----------------------------------

function getVanaMidnight(day)
    local curtime = os.time()
    if day ~= nil then
        curtime = curtime + 24 * 144 * day
    end

    local finaltime = curtime + (23 - VanadielHour()) * 144 + (60 - VanadielMinute()) * 2.4
    return finaltime
end

-----------------------------------
--  getConquestTally()
--  Returns the end of the current conquest tally
-----------------------------------

function getConquestTally()
    local lastTally = (JstWeekday() + 6) % 7
    local daysToTally = 6 - lastTally
    return getMidnight() + (daysToTally * (60 * 60 * 24))
end

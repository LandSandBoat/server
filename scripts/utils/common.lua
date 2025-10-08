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
--  getVanaMidnight(day)
--  Returns earth time value for midnight for current (or supplied day) in epoch format
-----------------------------------

function getVanaMidnight(day)
    local curtime           = GetSystemTime()
    local secondsToMidnight = xi.vanaTime.DAY - (VanadielTime() % xi.vanaTime.DAY)

    if day ~= nil then
        secondsToMidnight = secondsToMidnight + (day * xi.vanaTime.DAY)
    end

    return curtime + secondsToMidnight
end

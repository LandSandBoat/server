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

-----------------------------------
--  getVanadielMoonCycle()
--  Returns the current moon cycle index (0–11) based on Vanadiel moon phase and direction
-----------------------------------
function getVanadielMoonCycle()
    local phase = VanadielMoonPhase()
    local direction = VanadielMoonDirection()

    local moonTable =
    {
        -- Peak State
        [0] =
        {
            { 100, xi.moonCycle.FULL_MOON },                -- Full Moon                - 100% Full
            { 0,   xi.moonCycle.NEW_MOON },                 -- New Moon                 - 0% Full
        },
        -- Descending
        [1] =
        {
            { 94, xi.moonCycle.FULL_MOON },                 -- Full Moon                - 100 to 94%
            { 77, xi.moonCycle.GREATER_WANING_GIBBOUS },    -- Greater Waning Gibbous   - 93 to 77%
            { 61, xi.moonCycle.LESSER_WANING_GIBBOUS },     -- Lesser Waning Gibbous    - 76 to 61%
            { 41, xi.moonCycle.THIRD_QUARTER },             -- Third Quarter            - 60 to 41%
            { 25, xi.moonCycle.GREATER_WANING_CRESCENT },   -- Greater Waning Crescent  - 40 to 25%
            { 11, xi.moonCycle.LESSER_WANING_CRESCENT },    -- Lesser Waning Crescent   - 24 to 11%
            { 0,  xi.moonCycle.NEW_MOON },                  -- New Moon                 - 10 to 0%
        },
        -- Ascending
        [2] =
        {
            { 90, xi.moonCycle.FULL_MOON },                 -- Full Moon                - 100 to 90%
            { 72, xi.moonCycle.GREATER_WAXING_GIBBOUS },    -- Greater Waxing Gibbous   - 89 to 72%
            { 56, xi.moonCycle.LESSER_WAXING_GIBBOUS },     -- Lesser Waxing Gibbous    - 71 to 56%
            { 39, xi.moonCycle.FIRST_QUARTER },             -- First Quarter            - 55 to 39%
            { 22, xi.moonCycle.GREATER_WAXING_CRESCENT },   -- Greater Waxing Crescent  - 38 to 22%
            {  6, xi.moonCycle.LESSER_WAXING_CRESCENT },    -- Lesser Waxing Crescent   - 21 to 6%
            {  0, xi.moonCycle.NEW_MOON },                  -- New Moon                 - 5 to 0%
        },
    }

    local directionTable = moonTable[direction]
    if not directionTable then
        return xi.moonCycle.GREATER_WANING_GIBBOUS -- Greater Waxing Gibbous is the least offensive as base case.
    end

    -- Itterate down and trigger on the first matching phase
    for _, entry in ipairs(directionTable) do
        local threshold, moonCycle = entry[1], entry[2]
        if phase >= threshold then
            return moonCycle
        end
    end

    return xi.moonCycle.GREATER_WANING_GIBBOUS -- Greater Waxing Gibbous is the least offensive as base case. (Shouldn't be able to hit this.)
end

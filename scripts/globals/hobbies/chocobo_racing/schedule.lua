-----------------------------------
-- Chocobo Racing: Schedule
-- https://www.bg-wiki.com/ffxi/Category:Chocobo_Racing
-- https://ffxiclopedia.fandom.com/wiki/Chocobo_Racing_Guide
-----------------------------------
xi = xi or {}
xi.chocoboRacing = xi.chocoboRacing or {}

xi.chocoboRacing.schedule =
{
    PERIOD     = 900,     -- A race every 15 minutes.
    OFFSET     = 1848287, -- Race N starts in 15 minute slot N + OFFSET since the Unix epoch, lines up with retail.
    BETS_CLOSE = 47,      -- Seconds into its slot when betting on a race closes.
    START      = 359,     -- Seconds into its slot when a race starts.
    END        = 555,     -- Seconds into its slot when a race is over and its tickets can be cashed.
    WRAP       = 0x40000, -- Players see the race number in 18 bits.
}

-- Grade by race number % 8, starting at 0.
local gradeCycle =
{
    xi.chocoboRacing.raceGrade.C4,
    xi.chocoboRacing.raceGrade.C3,
    xi.chocoboRacing.raceGrade.C3,
    xi.chocoboRacing.raceGrade.C2,
    xi.chocoboRacing.raceGrade.C4,
    xi.chocoboRacing.raceGrade.C3,
    xi.chocoboRacing.raceGrade.C2,
    xi.chocoboRacing.raceGrade.C1,
}

-- Race starting in the 15 minute slot holding this timestamp.
---@param timestamp integer
---@return integer
xi.chocoboRacing.raceNoAt = function(timestamp)
    return math.floor(timestamp / xi.chocoboRacing.schedule.PERIOD) - xi.chocoboRacing.schedule.OFFSET
end

-- Race starting in the current 15 minute slot.
---@return integer
xi.chocoboRacing.currentRaceNo = function()
    return xi.chocoboRacing.raceNoAt(GetSystemTime())
end

-- Timestamp of a number of seconds into the slot of a race.
---@param raceNo integer
---@param seconds integer
---@return integer
xi.chocoboRacing.timeInSlot = function(raceNo, seconds)
    return (raceNo + xi.chocoboRacing.schedule.OFFSET) * xi.chocoboRacing.schedule.PERIOD + seconds
end

--- Latest race of a color that is on the toteboard.
---@param color integer
---@return integer
xi.chocoboRacing.raceNoForColor = function(color)
    local newest = xi.chocoboRacing.raceNoAt(GetSystemTime() - xi.chocoboRacing.schedule.BETS_CLOSE) + 2

    return newest - (xi.chocoboRacing.getRaceColor(newest) - color) % 4
end

-- Race number as players see it.
---@param raceNo integer
---@return integer
xi.chocoboRacing.shownRaceNo = function(raceNo)
    return raceNo % xi.chocoboRacing.schedule.WRAP
end

---@param raceNo integer
---@return xi.chocoboRacing.raceGrade
xi.chocoboRacing.getRaceGrade = function(raceNo)
    return gradeCycle[raceNo % #gradeCycle + 1]
end

-- Grade and race number as events, tickets and the toteboard carry them.
---@param raceNo integer
---@return integer
xi.chocoboRacing.getRaceId = function(raceNo)
    return bit.lshift(xi.chocoboRacing.getRaceGrade(raceNo), 18) + xi.chocoboRacing.shownRaceNo(raceNo)
end

-- Uniform color of the attendants handling the race. Also picks which Master announces it.
---@param raceNo integer
---@return integer
xi.chocoboRacing.getRaceColor = function(raceNo)
    return raceNo % 4
end

---@param raceNo integer
---@return integer
xi.chocoboRacing.getRaceNameId = function(raceNo)
    return zones[xi.zone.CHOCOBO_CIRCUIT].text.RACE_NAME_OFFSET + 2 * xi.chocoboRacing.getRaceGrade(raceNo)
end

-----------------------------------
-- Chocobo Racing: Schedule
-- https://www.bg-wiki.com/ffxi/Category:Chocobo_Racing
-- https://ffxiclopedia.fandom.com/wiki/Chocobo_Racing_Guide
-----------------------------------
xi = xi or {}
xi.chocoboRacing = xi.chocoboRacing or {}

xi.chocoboRacing.schedule =
{
    PERIOD = 900,     -- A race every 15 minutes.
    OFFSET = 1848287, -- Race N starts in 15 minute slot N + OFFSET since the Unix epoch, lines up with retail.
    WRAP   = 0x40000, -- Players see the race number in 18 bits; retail's last wrapped to 0 in September 2022.
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

-- Uniform colour of the attendants handling the race. Also picks which Master announces it.
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

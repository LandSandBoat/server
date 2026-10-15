-----------------------------------
-- Chocobo Racing: Toteboard
-- The toteboards and the paddock: the field, odds and betting countdown of the next race to close.
-----------------------------------
xi = xi or {}
xi.chocoboRacing = xi.chocoboRacing or {}

-- Update options the toteboard event sends.
local boardOption =
{
    OPEN    = 3,
    REFRESH = 4,
}

local paddockShift = 3
local paddockLanes = 8

-- 0x09B request kinds.
local requestKind =
{
    ODDS = 1,
}

--- The next race whose betting closes.
---@return integer
local function boardRaceNo()
    return xi.chocoboRacing.raceNoAt(GetSystemTime() - xi.chocoboRacing.schedule.BETS_CLOSE) + 1
end

---@param player CBaseEntity
---@param eventId integer
xi.chocoboRacing.onToteboardTrigger = function(player, eventId)
    -- Retail sends the weather of the next race to start.
    local nextStart = xi.chocoboRacing.getRace(xi.chocoboRacing.raceNoAt(GetSystemTime() - xi.chocoboRacing.schedule.START) + 1)
    local weather   = xi.weather.SUNSHINE
    if nextStart then
        weather = nextStart.weather
    end

    player:startEvent(
        eventId,                                  -- NPC Event ID
        weather,                                  -- Weather of the next race to start
        math.floor(player:getXPos() * 1000),      -- PC position, in thousandths
        math.floor(player:getZPos() * 1000),
        math.floor(player:getYPos() * 1000),
        player:getRotPos() * 16,                  -- PC rotation, retail sends rot * 16
        0,                                        -- Varies on retail, meaning unknown
        GetSystemTime() - xi.time.VANADIEL_EPOCH, -- Server timestamp, appears to be unused by event
        2                                         -- 2 opens the board, -1 shows "Preparations for the next race are underway"
    )
end

--- The "Betting ends in..." countdown. The client then asks for the odds and the field of the races of this color.
---@param player CBaseEntity
---@param closesIn integer
---@param weather integer
---@param color integer
xi.chocoboRacing.showBoard = function(player, closesIn, weather, color)
    player:updateEvent(
        closesIn,
        GetSystemTime() - xi.time.VANADIEL_EPOCH, -- Server time. The client uses it to time its refresh.
        0, 0, 0,
        closesIn,
        weather,
        color
    )
end

---@param player CBaseEntity
---@param chocobo ChocoboRacer
---@param first integer
---@param weather integer
---@param last integer
xi.chocoboRacing.showPaddock = function(player, chocobo, first, weather, last)
    local stats = chocobo.stats

    -- One stat per byte, then the DNA bitfield as the race packet carries it.
    local statBytes = bit.bor(stats.str, bit.lshift(stats['end'], 8), bit.lshift(stats.dsc, 16), bit.lshift(stats.rcp, 24))
    local dna       = bit.bor(bit.lshift(chocobo.ability1, 9), bit.lshift(chocobo.ability2, 13), bit.lshift(chocobo.temperament, 17), bit.lshift(chocobo.weather, 20), bit.lshift(chocobo.gender, 24),
        bit.lshift(chocobo.color, 25), bit.lshift(chocobo.size, 28))

    player:updateEventString(chocobo.name, chocobo.name, chocobo.name, chocobo.name)
    player:updateEvent(first, 0, chocobo.orders, chocobo.item, statBytes, dna, weather, last)
end

---@param player CBaseEntity
---@param option integer
xi.chocoboRacing.onToteboardEventUpdate = function(player, option)
    local raceNo = boardRaceNo()

    if option == boardOption.OPEN or option == boardOption.REFRESH then
        xi.chocoboRacing.showBoard(player, xi.chocoboRacing.timeInSlot(raceNo, xi.chocoboRacing.schedule.BETS_CLOSE) - GetSystemTime(), 1, xi.chocoboRacing.getRaceColor(raceNo))

        return
    end

    local lane = bit.rshift(option, paddockShift)

    -- Early return: not a paddock lane.
    if option ~= bit.lshift(lane, paddockShift) or lane >= paddockLanes then
        return
    end

    local race = xi.chocoboRacing.getRace(raceNo)

    -- Early return: the race is not posted yet.
    if not race then
        return
    end

    xi.chocoboRacing.showPaddock(player, race.chocobos[lane + 1], 6, 1, lane * 2)
end

--- The odds or the field of the newest race of a color that has opened for bets.
---@param player CBaseEntity
---@param param integer
---@param kind integer
---@return table
xi.chocoboRacing.onRaceRequest = function(player, param, kind)
    -- Early return: the client asks by attendant color, 0 to 3.
    if param > 3 then
        return {}
    end

    local raceNo = xi.chocoboRacing.raceNoForColor(param)

    if kind == requestKind.ODDS then
        -- Odds per quinella pair in order 1-2, 1-3 ... 1-8, 2-3 ... 7-8; 50000 is no bet.
        return
        {
            grade      = xi.chocoboRacing.getRaceGrade(raceNo),
            raceNumber = xi.chocoboRacing.shownRaceNo(raceNo),
            odds       = xi.chocoboRacing.getOdds(raceNo),
        }
    end

    local race = xi.chocoboRacing.getRace(raceNo)

    -- Early return: the race is not posted yet, so the field is empty.
    if not race then
        return { weather = xi.weather.SUNSHINE }
    end

    return
    {
        weather  = race.weather,
        chocobos = race.chocobos,
    }
end

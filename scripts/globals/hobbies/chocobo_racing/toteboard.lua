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

-- Paddock options pick a lane: option = (lane - 1) * paddockStep, lanes 1 to 8.
local paddockStep  = 8
local paddockLanes = 8

-- 0x09B request kinds.
local requestKind =
{
    ODDS = 1,
}

-- No bets on any of the 28 quinella pairs.
-- TODO: Odds from the betting pools.
local noBets = {}
for pair = 1, 28 do
    noBets[pair] = 50000
end

--- The next race whose betting closes.
-- TODO: The toteboard shows this race until the betting counters pick their own race.
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

---@param player CBaseEntity
---@param option integer
xi.chocoboRacing.onToteboardEventUpdate = function(player, option)
    local raceNo = boardRaceNo()

    -- Opening the board, or the client's periodic refresh: the "Betting ends in..." countdown.
    if option == boardOption.OPEN or option == boardOption.REFRESH then
        local closesAt = (raceNo + xi.chocoboRacing.schedule.OFFSET) * xi.chocoboRacing.schedule.PERIOD + xi.chocoboRacing.schedule.BETS_CLOSE
        local closesIn = closesAt - GetSystemTime()
        player:updateEvent(
            closesIn,                                 -- Seconds until betting closes
            GetSystemTime() - xi.time.VANADIEL_EPOCH, -- Server time. The client uses it to time its refresh.
            0, 0, 0,
            closesIn,
            1,                                        -- Unknown
            0
        )
        return
    end

    -- Early return: not a paddock lane.
    if option % paddockStep ~= 0 or option >= paddockStep * paddockLanes then
        return
    end

    local race = xi.chocoboRacing.getRace(raceNo)

    -- Early return: the race is not posted yet.
    if not race then
        return
    end

    local lane    = option / paddockStep + 1
    local chocobo = race.chocobos[lane]
    local stats   = chocobo.stats

    -- One stat per byte, then the DNA bitfield as the race packet carries it.
    local statBytes = bit.bor(stats.str, bit.lshift(stats['end'], 8), bit.lshift(stats.dsc, 16), bit.lshift(stats.rcp, 24))
    local dna       = bit.bor(bit.lshift(chocobo.ability1, 9), bit.lshift(chocobo.ability2, 13), bit.lshift(chocobo.temperament, 17), bit.lshift(chocobo.weather, 20), bit.lshift(chocobo.gender, 24),
        bit.lshift(chocobo.color, 25), bit.lshift(chocobo.size, 28))

    player:updateEventString(chocobo.name, chocobo.name, chocobo.name, chocobo.name)
    player:updateEvent(6, 0, chocobo.orders, chocobo.item, statBytes, dna, 1, (lane - 1) * 2)
end

--- The toteboard's requests: the odds, or the field.
---@param player CBaseEntity
---@param param integer
---@param kind integer
---@return table
xi.chocoboRacing.onRaceRequest = function(player, param, kind)
    local raceNo = boardRaceNo()

    if kind == requestKind.ODDS then
        -- Odds per quinella pair in order 1-2, 1-3 ... 1-8, 2-3 ... 7-8; 50000 is no bet.
        return
        {
            grade      = xi.chocoboRacing.getRaceGrade(raceNo),
            raceNumber = xi.chocoboRacing.shownRaceNo(raceNo),
            odds       = noBets,
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

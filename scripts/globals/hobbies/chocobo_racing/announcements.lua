-----------------------------------
-- Chocobo Racing: Announcements
-- The Masters and the TimeKeeper call out each race to the whole zone.
-----------------------------------
xi = xi or {}
xi.chocoboRacing = xi.chocoboRacing or {}

local vars =
{
    LAST_TICK = '[ChocoboRacing]LastTick',
}

---@param players CBaseEntity[]
---@param speaker CBaseEntity?
---@param messageId integer
local announce = function(players, speaker, messageId)
    if not speaker then
        return
    end

    for _, player in ipairs(players) do
        player:messageText(speaker, messageId, false, 5)
    end
end

---@param players CBaseEntity[]
---@param speaker CBaseEntity?
---@param messageId integer
---@param params integer[]
local announceWithParams = function(players, speaker, messageId, params)
    for _, player in ipairs(players) do
        player:messageName(messageId, nil, params[1], params[2], params[3], params[4], 5, speaker, false)
    end
end

-- Header, race name, footer. The footer carries the attendant colour on the signup and betting announcements.
---@param players CBaseEntity[]
---@param raceNo integer
---@param header integer
---@param footer integer
---@param nameParam integer
---@param color integer?
local announceRace = function(players, raceNo, header, footer, nameParam, color)
    local ID      = zones[xi.zone.CHOCOBO_CIRCUIT]
    local speaker = GetNPCByID(ID.npc.MASTER_OFFSET + xi.chocoboRacing.getRaceColor(raceNo))
    local nameId  = xi.chocoboRacing.getRaceNameId(raceNo)

    announce(players, speaker, header)
    announceWithParams(players, speaker, nameId, { xi.chocoboRacing.shownRaceNo(raceNo), nameId, nameParam, 0 })

    if color then
        announceWithParams(players, speaker, footer, { xi.chocoboRacing.shownRaceNo(raceNo), nameId, color, 0 })
    else
        announce(players, speaker, footer)
    end
end

-- Announcements by seconds into the slot of the race starting in it.
---@type table<integer, fun(players: CBaseEntity[], raceNo: integer)>
local announcements =
{
    [23] = function(players, raceNo)
        local ID   = zones[xi.zone.CHOCOBO_CIRCUIT]
        local race = raceNo + 3
        announceRace(players, race, ID.text.SIGNUPS_OPEN, ID.text.SIGNUPS_ATTENDANT, 30, xi.chocoboRacing.getRaceColor(race))
    end,

    [29] = function(players, raceNo)
        local ID   = zones[xi.zone.CHOCOBO_CIRCUIT]
        local race = raceNo + 2
        announceRace(players, race, ID.text.SIGNUPS_CLOSED, ID.text.SIGNUPS_CLOSED_END, (race + 1) % 4)
    end,

    [47] = function(players, raceNo)
        local ID   = zones[xi.zone.CHOCOBO_CIRCUIT]
        local race = raceNo + 2
        announceRace(players, race, ID.text.BETS_OPEN, ID.text.BETS_ATTENDANT, (race + 1) % 4, xi.chocoboRacing.getRaceColor(race))
    end,

    [53] = function(players, raceNo)
        local ID = zones[xi.zone.CHOCOBO_CIRCUIT]
        announceRace(players, raceNo, ID.text.BETS_CLOSING, ID.text.BETS_CLOSING_END, 0)
        announce(players, GetNPCByID(ID.npc.MASTER_OFFSET + xi.chocoboRacing.getRaceColor(raceNo)), ID.text.PROCEED_TO_GRANDSTAND)
    end,

    [359] = function(players, raceNo)
        local ID = zones[xi.zone.CHOCOBO_CIRCUIT]
        announceRace(players, raceNo, ID.text.RACE_STARTING, ID.text.RACE_STARTING_END, 0)
    end,

    [625] = function(players)
        local ID = zones[xi.zone.CHOCOBO_CIRCUIT]
        announce(players, GetNPCByID(ID.npc.TIMEKEEPER), ID.text.LATEST_TEAM_STANDINGS)
    end,

    -- TODO: Team standings, 4 shows ??? for every team.
    [631] = function(players)
        local ID = zones[xi.zone.CHOCOBO_CIRCUIT]
        announceWithParams(players, GetNPCByID(ID.npc.TIMEKEEPER), ID.text.CURRENT_STANDINGS, { 4, 4, 4, 0 })
    end,
}

-- Runs every announcement whose time came up since the last tick.
---@param zone CZone
xi.chocoboRacing.onZoneTick = function(zone)
    if not xi.chocoboRacing.settings.ENABLED then
        return
    end

    local now      = GetSystemTime()
    local lastTick = zone:getLocalVar(vars.LAST_TICK)
    zone:setLocalVar(vars.LAST_TICK, now)

    if lastTick == 0 or now <= lastTick then
        return
    end

    local players = zone:getPlayers()
    for timestamp = math.max(lastTick + 1, now - 60), now do
        local announcement = announcements[timestamp % xi.chocoboRacing.schedule.PERIOD]
        if announcement then
            announcement(players, xi.chocoboRacing.raceNoAt(timestamp))
        end
    end
end

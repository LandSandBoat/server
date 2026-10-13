-----------------------------------
-- Chocobo Racing: Broadcast
-- Stream the race to the players in the grandstands
-----------------------------------
xi = xi or {}
xi.chocoboRacing = xi.chocoboRacing or {}

-- Event 210 and the update options the client sends during it.
local raceEvent =
{
    ID          = 210,
    FLAGS       = 9,
    FILLER      = 10, -- Retail leaves stale values in start param 2 and echoes them in the intro update.
    INTRO       = 5,
    FIRST_HALF  = 274,
    SECOND_HALF = 530,
    PAYOUT      = 17,
    SHOWING     = -5, -- Last update param: the race is ready to show.
}

-- Only players in the grandstand see the race. The rest of the zone hears only the announcements.
local grandstand =
{
    x = { -125, -5 },
    y = { -20, -9 },
    z = { -145, -98 },
}

---@param players CBaseEntity[]
---@param raceNo integer
xi.chocoboRacing.broadcastRace = function(players, raceNo)
    local race   = assert(xi.chocoboRacing.getRace(raceNo))
    local raceId = xi.chocoboRacing.getRaceId(raceNo)

    for _, player in ipairs(players) do
        local x = player:getXPos()
        local y = player:getYPos()
        local z = player:getZPos()
        if
            x >= grandstand.x[1] and x <= grandstand.x[2] and
            y >= grandstand.y[1] and y <= grandstand.y[2] and
            z >= grandstand.z[1] and z <= grandstand.z[2] and
            not player:isInEvent()
        then
            player:startEvent(raceEvent.ID, { [0] = raceId, [1] = raceId, [2] = raceEvent.FILLER, flags = raceEvent.FLAGS })
            player:sendChocoboRace({
                counter  = xi.chocoboRacing.getRaceColor(raceNo),
                weather  = race.weather,
                chocobos = race.chocobos,
                sections = race.sections,
                places   = race.places,
            })
        end
    end
end

---@param player CBaseEntity
---@param csid integer
---@param option integer
---@param npc CBaseEntity?
xi.chocoboRacing.onEventUpdate = function(player, csid, option, npc)
    -- Early return: not the race event.
    if csid ~= raceEvent.ID then
        return
    end

    local race   = xi.chocoboRacing.getRace(xi.chocoboRacing.currentRaceNo())
    local places = race and race.places
    local intro  = race and race.intro

    -- Early return: the current race has not run, so it has no result to show yet.
    if not race or race.runAt == 0 or not places or not intro then
        return
    end

    -- The result as the race event expects it: each chocobo's 0-based place in 4 bits, chocobo 1 in the lowest.
    local result = 0
    for lane = #places, 1, -1 do
        result = result * 16 + places[lane]
    end

    -- The higher 0-based lane of the first two finishers.
    local topLane = 0
    for lane = 1, #places do
        if places[lane] <= 1 then
            topLane = lane - 1
        end
    end

    if option == raceEvent.INTRO then
        player:updateEvent(xi.chocoboRacing.getRaceColor(race.raceNo), 0, raceEvent.FILLER, 0, result, 0, 0, raceEvent.SHOWING)
    elseif option == raceEvent.FIRST_HALF or option == raceEvent.SECOND_HALF then
        local half  = option == raceEvent.FIRST_HALF and 1 or 2
        local first = half * 4 - 3
        player:updateEventString(race.chocobos[first].name, race.chocobos[first + 1].name, race.chocobos[first + 2].name, race.chocobos[first + 3].name)
        player:updateEvent(intro[half], 0, topLane, 0, result, 0, 0, raceEvent.SHOWING)
    elseif option == raceEvent.PAYOUT then
        player:updateEvent(0, 0, xi.chocoboRacing.getQuinella(race).payout, 0, result, 0, 0, raceEvent.SHOWING)
    end
end

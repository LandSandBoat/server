-----------------------------------
-- Manaclipper
-- https://ffxiclopedia.fandom.com/wiki/Manaclipper
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/zone")
-----------------------------------

xi = xi or {}
xi.manaclipper = xi.manaclipper or {}

local act =
{
    ARRIVE = 0,
    DEPART = 1,
}

-- manaclipper destinations
local dest =
{
    DHALMEL_ROCK      = 0,
    MALIYAKALEYA_REEF = 1,
    PURGONORGO_ISLE   = 2,
    SUNSET_DOCKS      = 3,
}

-- locations for timekeeper NPCs
xi.manaclipper.location =
{
    SUNSET_DOCKS    = 0,
    PURGONORGO_ISLE = 1,
    MANACLIPPER     = 2,
}

local manaclipperSchedule =
{
    [xi.manaclipper.location.SUNSET_DOCKS] =
    {
        { time =   10, act = act.ARRIVE, dest = dest.DHALMEL_ROCK },      -- 00:10
        { time =   50, act = act.DEPART, dest = dest.DHALMEL_ROCK },      -- 00:50
        { time =  290, act = act.ARRIVE, dest = dest.PURGONORGO_ISLE },   -- 04:50
        { time =  330, act = act.DEPART, dest = dest.PURGONORGO_ISLE },   -- 05:30
        { time =  730, act = act.ARRIVE, dest = dest.MALIYAKALEYA_REEF }, -- 12:10
        { time =  770, act = act.DEPART, dest = dest.MALIYAKALEYA_REEF }, -- 12:50
        { time = 1010, act = act.ARRIVE, dest = dest.PURGONORGO_ISLE },   -- 16:50
        { time = 1050, act = act.DEPART, dest = dest.PURGONORGO_ISLE },   -- 17:30
        { time = 1450, act = act.ARRIVE, dest = dest.DHALMEL_ROCK },      -- 24:10
    },

    [xi.manaclipper.location.PURGONORGO_ISLE] =
    {
        { time =  510, act = act.ARRIVE, dest = dest.SUNSET_DOCKS }, -- 08:30
        { time =  555, act = act.DEPART, dest = dest.SUNSET_DOCKS }, -- 09:15
        { time = 1230, act = act.ARRIVE, dest = dest.SUNSET_DOCKS }, -- 20:30
        { time = 1275, act = act.DEPART, dest = dest.SUNSET_DOCKS }, -- 21:15
        { time = 1950, act = act.ARRIVE, dest = dest.SUNSET_DOCKS }, -- 32:30
    },

    [xi.manaclipper.location.MANACLIPPER] =
    {
        { time =   10, act = act.ARRIVE, route = dest.SUNSET_DOCKS },      -- 00:10
        { time =  290, act = act.ARRIVE, route = dest.DHALMEL_ROCK },      -- 04:50
        { time =  510, act = act.ARRIVE, route = dest.PURGONORGO_ISLE },   -- 08:30
        { time =  730, act = act.ARRIVE, route = dest.SUNSET_DOCKS },      -- 12:10
        { time = 1010, act = act.ARRIVE, route = dest.MALIYAKALEYA_REEF }, -- 16:50
        { time = 1230, act = act.ARRIVE, route = dest.PURGONORGO_ISLE },   -- 20:30
        { time = 1450, act = act.ARRIVE, route = dest.SUNSET_DOCKS },      -- 24:10
    },
}

xi.manaclipper.timekeeperOnTrigger = function(player, location, eventId)
    local schedule = manaclipperSchedule[location]

    if schedule then
        local currentTime = VanadielHour() * 60 + VanadielMinute()
        local nextEvent = nil

        for i = 1, #schedule do
            if schedule[i].time > currentTime then
                nextEvent = schedule[i]
                break
            end
        end

        local gameMins = nextEvent.time - currentTime
        local earthSecs = gameMins * 60 / 25 -- one earth second is 25 game seconds

        if location == xi.manaclipper.location.MANACLIPPER then
            local earthMins = math.ceil(earthSecs / 60)
            local gameHours = math.floor(gameMins / 60)
            player:startEvent(eventId, earthMins, gameHours, nextEvent.route)
        else
            player:startEvent(eventId, earthSecs, nextEvent.act, 0, nextEvent.dest)
        end
    else
        printf("[warning] bad location %i in xi.manaclipper.timekeeperOnTrigger", location)
    end
end

xi.manaclipper.aboard = function(player, triggerArea, isAboard)
    player:setCharVar("[manaclipper]aboard", isAboard and triggerArea or 0)
end

xi.manaclipper.onZoneIn = function(player)
    local zoneId = player:getZoneID()

    -- zoning onto manaclipper. set [manaclipper]arrivalEventId based on schedule.
    if zoneId == xi.zone.MANACLIPPER then
        local schedule = manaclipperSchedule[xi.manaclipper.location.MANACLIPPER]
        local currentTime = VanadielHour() * 60 + VanadielMinute()
        local nextEvent = nil

        for i = 1, #schedule do
            if schedule[i].time > currentTime then
                nextEvent = schedule[i]
                break
            end
        end

        if nextEvent.route == dest.PURGONORGO_ISLE then
            player:setCharVar("[manaclipper]arrivalEventId", 13) -- Bibiki event 13 sets pos then chains to 11: arrive at Purgonorgo Isle
        else
            player:setCharVar("[manaclipper]arrivalEventId", 12) -- Bibiki event 12 sets pos then chains to 10: arrive at Sunset Docks
        end

    -- zoning into bibiki bay. play the eventId stored in [manaclipper]arrivalEventId.
    elseif zoneId == xi.zone.BIBIKI_BAY then
        local eventId = player:getCharVar("[manaclipper]arrivalEventId")
        player:setCharVar("[manaclipper]arrivalEventId", 0)

        if eventId > 0 then
            return eventId
        else
            player:setPos(669.917, -23.138, 911.655, 111)
            return -1
        end
    end
end

xi.manaclipper.onTransportEvent = function(player, transport)
    local ID = zones[player:getZoneID()]
    local aboard = player:getCharVar("[manaclipper]aboard")

    -- leaving Sunset Docks. must be standing in trigger area 1. must have a ticket.
    if aboard == 1 then
        if player:hasKeyItem(xi.ki.MANACLIPPER_TICKET) then
            player:delKeyItem(xi.ki.MANACLIPPER_TICKET)
            player:startEvent(14)
        elseif player:hasKeyItem(xi.ki.MANACLIPPER_MULTI_TICKET) then
            local uses = player:getCharVar("Manaclipper_Ticket")

            if uses == 1 then
                player:messageSpecial(ID.text.END_BILLET, 0, xi.ki.MANACLIPPER_MULTI_TICKET)
                player:delKeyItem(xi.ki.MANACLIPPER_MULTI_TICKET)
            else
                player:messageSpecial(ID.text.LEFT_BILLET, 0, xi.ki.MANACLIPPER_MULTI_TICKET, uses - 1)
            end

            player:setCharVar("Manaclipper_Ticket", uses - 1)
            player:startEvent(14)
        else
            player:messageSpecial(ID.text.NO_BILLET, xi.ki.MANACLIPPER_TICKET)
            player:setPos(489, -3, 713, 200) -- kicked off Manaclipper, returned to Sunset Docks
        end

    -- leaving Purgonorgo Isle. must be standing in trigger area 2. no ticket required.
    elseif aboard == 2 then
        player:startEvent(16)
    end
end

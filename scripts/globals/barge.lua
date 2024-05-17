-----------------------------------
-- Carpenters' Landing Barge
-- https://www.bg-wiki.com/ffxi/Phanauet_Channel
-----------------------------------
xi = xi or {}
xi.barge = xi.barge or {}

local actions =
{
    ARRIVE = 0,
    DEPART = 1,
}

-- Barge destinations
local destinations =
{
    NORTH_LANDING   = 0,
    CENTRAL_LANDING = 1,
    SOUTH_LANDING   = 2,
}

-- Locations for timekeeper NPCs
xi.barge.location =
{
    NORTH_LANDING    = 0,
    CENTRAL_LANDING  = 1,
    SOUTH_LANDING    = 2,
    PHANAUET_CHANNEL = 3,
}

local bargeSchedule =
{
    [xi.barge.location.NORTH_LANDING] =
    {
        { time =  960, action = actions.ARRIVE, route = destinations.CENTRAL_LANDING }, -- 16:00
        { time = 1045, action = actions.DEPART, route = destinations.CENTRAL_LANDING }, -- 17:25
    },
    [xi.barge.location.CENTRAL_LANDING] =
    {
        { time =  275, action = actions.ARRIVE, route = destinations.SOUTH_LANDING },   -- 04:35
        { time =  310, action = actions.DEPART, route = destinations.SOUTH_LANDING },   -- 05:10
        { time = 1155, action = actions.ARRIVE, route = destinations.SOUTH_LANDING },   -- 19:15
        { time = 1190, action = actions.DEPART, route = destinations.SOUTH_LANDING },   -- 19:50
    },
    [xi.barge.location.SOUTH_LANDING] =
    {
        { time =   50, action = actions.DEPART, route = destinations.CENTRAL_LANDING }, -- 00:50
        { time =  575, action = actions.ARRIVE, route = destinations.NORTH_LANDING },   -- 09:35
        { time =  660, action = actions.DPEART, route = destinations.NORTH_LANDING },   -- 10:10
        { time = 1415, action = actions.ARRIVE, route = destinations.CENTRAL_LANDING }, -- 23:35
    },
    [xi.barge.location.PHANAUET_CHANNEL] =
    {
        { time =  275, action = actions.ARRIVE, route = destinations.SOUTH_LANDING },   -- 04:35
        { time =  575, action = actions.ARRIVE, route = destinations.NORTH_LANDING },   -- 09:35
        { time =  960, action = actions.ARRIVE, route = destinations.CENTRAL_LANDING }, -- 16:00
        { time = 1155, action = actions.ARRIVE, route = destinations.SOUTH_LANDING },   -- 19:15
        { time = 1415, action = actions.ARRIVE, route = destinations.CENTRAL_LANDING }, -- 23:35
    },
}

xi.barge.timekeeperOnTrigger = function(player, location, eventId)
    local schedule = bargeSchedule[location]

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

        if location == xi.barge.location.PHANAUET_CHANNEL then
            local earthMins = math.ceil(earthSecs / 60)
            local gameHours = math.floor(gameMins / 60)
            player:startEvent(eventId, earthMins, gameHours, nextEvent.route)
        else
            player:startEvent(eventId, earthSecs, nextEvent.action, 0, nextEvent.route)
        end
    else
        printf('[warning] bad location %i in xi.barge.timekeeperOnTrigger', location)
    end
end

xi.barge.aboard = function(player, triggerArea, isAboard)
    player:setCharVar('[barge]aboard', isAboard and triggerArea or 0)
end

xi.barge.onZoneIn = function(player)
    local zoneId = player:getZoneID()

    -- Zoning into Phanauet Channel. Set [barge]arrivalEventId based on schedule.
    if zoneId == xi.zone.PHANAUET_CHANNEL then
        local schedule = bargeSchedule[xi.barge.location.PHANAUET_CHANNEL]
        local currentTime = VanadielHour() * 60 + VanadielMinute()
        local nextEvent = nil

        for i = 1, #schedule do
            if schedule[i].time > currentTime then
                nextEvent = schedule[i]
                break
            end
        end

        if nextEvent == nil then -- schedule is on the next day
            nextEvent = schedule[1]
        end

        if nextEvent.route == destinations.NORTH_LANDING then
            player:setCharVar('[barge]arrivalEventId', 11)
        elseif nextEvent.route == destinations.CENTRAL_LANDING then
            player:setCharVar('[barge]arrivalEventId', 10)
        elseif nextEvent.route == destinations.SOUTH_LANDING then
            player:setCharVar('[barge]arrivalEventId', 38)
        end

    -- Zoning into Carpteners' Landing. Play the eventId stored in [barge]arrivalEventId.
    elseif zoneId == xi.zone.CARPENTERS_LANDING then
        local eventId = player:getCharVar('[barge]arrivalEventId')
        player:setCharVar('[barge]arrivalEventId', 0)

        if eventId > 0 then
            return eventId
        else
            player:setPos(-136.983, -1.969, 60.653, 95, 2)
            return -1
        end
    end
end

xi.barge.onTransportEvent = function(player, transport)
    local ID = zones[player:getZoneID()]
    local aboard = player:getCharVar('[barge]aboard')
    local departEvent = -1
    local kickEvent = -1

    -- South Landing
    if aboard == 1 then
        departEvent = 14
        kickEvent = 33
    -- Central Landing
    elseif aboard == 2 then
        departEvent = 40
        kickEvent = 42
    -- North Landing
    elseif aboard == 3 then
        departEvent = 16
        kickEvent = 34
    end

    if aboard > 0 then
        if player:hasKeyItem(xi.ki.BARGE_TICKET) then
            player:delKeyItem(xi.ki.BARGE_TICKET)
            player:startEvent(departEvent)
        elseif player:hasKeyItem(xi.ki.BARGE_MULTI_TICKET) then
            local uses = player:getCharVar('Barge_Ticket')

            if uses == 1 then
                player:messageSpecial(ID.text.BARGE_TICKET_USED, 0, xi.ki.BARGE_MULTI_TICKET)
                player:delKeyItem(xi.ki.BARGE_MULTI_TICKET)
            else
                player:messageSpecial(ID.text.BARGE_TICKET_REMAINING, 0, xi.ki.BARGE_MULTI_TICKET, uses - 1)
            end

            player:setCharVar('Barge_Ticket', uses - 1)
            player:startEvent(departEvent)
        else
            player:startEvent(kickEvent)
        end
    end
end

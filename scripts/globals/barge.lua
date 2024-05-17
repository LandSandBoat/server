-----------------------------------
-- Carpenters' Landing Barge
-- https://www.bg-wiki.com/ffxi/Phanauet_Channel
-----------------------------------
xi = xi or {}
xi.barge = xi.barge or {}

local actions =
{
    ARRIVE     = 0,
    DEPART     = 1,
    ARRIVE_OOS = 2,
    DEPART_OOS = 3,
}

-- Barge destinations
local destinations =
{
    SOUTH_LANDING         = 0,
    CENTRAL_LANDING_EMFEA = 1,
    NORTH_LANDING         = 2,
    CENTRAL_LANDING       = 3,
}

-- Locations for timekeeper NPCs
xi.barge.location =
{
    NORTH_LANDING    = 1,
    CENTRAL_LANDING  = 2,
    SOUTH_LANDING    = 3,
    PHANAUET_CHANNEL = 4,
}

local bargeSchedule =
{
    [xi.barge.location.NORTH_LANDING] =
    {
        { time =  960, action = actions.ARRIVE_OOS, route = destinations.CENTRAL_LANDING }, -- 16:00
        { time =  975, action = actions.DEPART_OOS, route = destinations.CENTRAL_LANDING }, -- 16:15
        { time = 1005, action = actions.ARRIVE, route = destinations.CENTRAL_LANDING },     -- 16:45
        { time = 1045, action = actions.DEPART, route = destinations.CENTRAL_LANDING },     -- 17:25
    },
    [xi.barge.location.CENTRAL_LANDING] =
    {
        { time =  275, action = actions.ARRIVE, route = destinations.SOUTH_LANDING },  -- 04:35
        { time =  310, action = actions.DEPART, route = destinations.SOUTH_LANDING },  -- 05:10
        { time = 1155, action = actions.ARRIVE, route = destinations.SOUTH_LANDING },  -- 19:15
        { time = 1190, action = actions.DEPART, route = destinations.SOUTH_LANDING },  -- 19:50
    },
    [xi.barge.location.SOUTH_LANDING] =
    {
        { time =   15, action = actions.ARRIVE, route = destinations.CENTRAL_LANDING_EMFEA },     -- 00:15
        { time =   50, action = actions.DEPART, route = destinations.CENTRAL_LANDING_EMFEA },     -- 00:50
        { time =  535, action = actions.ARRIVE_OOS, route = destinations.NORTH_LANDING },         -- 08:55
        { time =  545, action = actions.DEPART_OOS, route = destinations.NORTH_LANDING },         -- 09:05
        { time =  575, action = actions.ARRIVE, route = destinations.NORTH_LANDING },             -- 09:35
        { time =  660, action = actions.DEPART, route = destinations.NORTH_LANDING },             -- 10:10
        { time = 1415, action = actions.ARRIVE_OOS, route = destinations.CENTRAL_LANDING_EMFEA }, -- 23:35
        { time = 1415, action = actions.DEPART_OOS, route = destinations.CENTRAL_LANDING_EMFEA }, -- 23:45
    },
    [xi.barge.location.PHANAUET_CHANNEL] =
    {
        { time =  275, action = actions.ARRIVE, route = destinations.CENTRAL_LANDING_EMFEA }, -- 04:35
        { time =  535, action = actions.ARRIVE, route = destinations.SOUTH_LANDING },         -- 08:55
        { time =  960, action = actions.ARRIVE, route = destinations.NORTH_LANDING },         -- 16:00
        { time = 1155, action = actions.ARRIVE, route = destinations.CENTRAL_LANDING },       -- 19:15
        { time = 1415, action = actions.ARRIVE, route = destinations.SOUTH_LANDING },         -- 23:35
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

        local time = 0

        if nextEvent == nil then
            nextEvent = schedule[1]
            time = 1440 -- next day
        end

        time = time + nextEvent.time

        local gameMins = time - currentTime
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

        if nextEvent == nil then
            nextEvent = schedule[1]
        end

        if nextEvent.route == destinations.NORTH_LANDING then
            player:setCharVar('[barge]arrivalEventId', 11)
        elseif
            nextEvent.route == destinations.CENTRAL_LANDING or
            nextEvent.route == destinations.CENTRAL_LANDING_EMFEA
        then
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

    if aboard == 0 then -- Not boarded
        return
    elseif aboard == 1 then -- South Landing
        departEvent = 14
        kickEvent = 33
    elseif aboard == 2 then -- Central Landing
        departEvent = 40
        kickEvent = 42
    elseif aboard == 3 then -- North Landing
        departEvent = 16
        kickEvent = 34
    end

    if player:hasKeyItem(xi.ki.BARGE_TICKET) then
        player:messageSpecial(ID.text.BARGE_TICKET_USED, 0, xi.ki.BARGE_TICKET)
        player:delKeyItem(xi.ki.BARGE_TICKET)
        player:startEvent(departEvent)
    elseif player:hasKeyItem(xi.ki.BARGE_MULTI_TICKET) then
        local uses = player:getCharVar('[barge]multiTicket')

        if uses <= 1 then
            player:messageSpecial(ID.text.BARGE_TICKET_USED, 0, xi.ki.BARGE_MULTI_TICKET)
            player:delKeyItem(xi.ki.BARGE_MULTI_TICKET)
        else
            player:messageSpecial(ID.text.BARGE_TICKET_REMAINING, 0, xi.ki.BARGE_MULTI_TICKET, uses - 1)
        end

        player:setCharVar('[barge]multiTicket', uses - 1)
        player:startEvent(departEvent)
    else
        player:startEvent(kickEvent)
    end
end

xi.barge.onTicketShopTrigger = function(player, eventId)
    player:setCharVar('[barge]currentTicket', 0) -- Set ticket to 0 in case something breaks

    if
        player:hasKeyItem(xi.ki.BARGE_TICKET) and
        player:hasKeyItem(xi.ki.BARGE_MULTI_TICKET)
    then
        player:setCharVar('[barge]currentTicket', 3)
    elseif player:hasKeyItem(xi.ki.BARGE_MULTI_TICKET) then
        player:setCharVar('[barge]currentTicket', 2)
    elseif player:hasKeyItem(xi.ki.BARGE_TICKET) then
        player:setCharVar('[barge]currentTicket', 1)
    else
        player:setCharVar('[barge]currentTicket', 0)
    end

    -- Params (KI1, KI2, Price of KI1, Price of KI2, Multiticket #s left, Which tickets does player have)
    player:startEvent(eventId, xi.ki.BARGE_TICKET, xi.ki.BARGE_MULTI_TICKET , 50, 300, player:getCharVar('[barge]multiTicket'), player:getCharVar('[barge]currentTicket'), 1, 4095) -- Start event
end

xi.barge.onTicketShopEventFinish = function(player, csid, option, npc)
    local ID = zones[player:getZoneID()]
    local currentTicket = player:getCharVar('[barge]currentTicket')
    local numberTicket = player:getCharVar('[barge]multiTicket')

    -- Option 1: BARGE_TICKET
    -- Option 2: MULTI_TICKET
    if
        csid == 31 or
        csid == 32 or
        csid == 43
    then
        local gil = player:getGil()
        if option == 1 and (currentTicket == 1 or currentTicket == 3) then -- If you have BARGE_TICKET
            -- Event auto plays the correct message
        elseif option == 1 then
            if gil >= 50 then
                player:delGil(50)
                player:addKeyItem(xi.ki.BARGE_TICKET)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BARGE_TICKET)
            else
                player:showText(npc, ID.text.TOO_POOR)
            end
        elseif
            option == 2 and
            (currentTicket == 2 or currentTicket == 3) and
            numberTicket <= 9
        then -- If you have multi ticket with less than 9
            if gil >= 300 then
                player:delGil(300)
                player:messageSpecial(ID.text.BARGE_TICKET_ADDED, xi.ki.BARGE_MULTI_TICKET, 10)
                player:setCharVar('[barge]multiTicket', 10)
            else
                player:showText(npc, ID.text.TOO_POOR)
            end
        elseif option == 2 then
            if gil >= 300 then
                player:delGil(300)
                player:addKeyItem(xi.ki.BARGE_MULTI_TICKET)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BARGE_MULTI_TICKET)
                player:setCharVar('[barge]multiTicket', 10)
            else
                player:showText(npc, ID.text.TOO_POOR)
            end
        else
            -- Event auto plays the correct message
        end
    end
end

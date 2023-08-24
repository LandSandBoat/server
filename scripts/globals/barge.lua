------------------------------------
-- Phanauet Channel
-- https://ffxiclopedia.fandom.com/wiki/Phanauet_Channel
------------------------------------
-- Cut Scenes
------------------------------------
require("scripts/globals/zone")
require("scripts/globals/npc_util")
local ID = require('scripts/zones/Carpenters_Landing/IDs')
------------------------------------
xi = xi or {}
xi.barge = xi.barge or {}

-- set true for debug output
local verbose = true

local act =
{
    ARRIVE     = 0,
    DEPART     = 1,
    ARRIVE_OOS = 2,
    DEPART_OOS = 3,
}

-- Barge Destinations
local dest =
{
    SOUTH_LANDING         = 0, -- South Landing via the main canal
    CENTRAL_LANDING       = 1, -- Central Landing via the main canal
    NORTH_LANDING         = 2, -- North Landing via the main canal
    CENTRAL_LANDING_EMFEA = 3, -- Central Landing via Emfea Waterway
}

-- Locations for timekeeper NPCs
xi.barge.location =
{
    NORTH_LANDING   = 1,
    CENTRAL_LANDING = 2,
    SOUTH_LANDING   = 3,
    BARGE           = 4,
}

local bargeSchedule =
{
    [xi.barge.location.NORTH_LANDING] = -- 1
    {
        { time =  965, act = act.ARRIVE_OOS, dest = dest.CENTRAL_LANDING }, -- 16:05 Arrive OOS
        { time =  973, act = act.DEPART_OOS, dest = dest.CENTRAL_LANDING }, -- 16:12 Depart OOS
        { time = 1005, act = act.ARRIVE,     dest = dest.CENTRAL_LANDING }, -- 16:45 to Central
        { time = 1045, act = act.DEPART,     dest = dest.CENTRAL_LANDING }, -- 17:25 to Central
        { time = 2405, act = act.DEPART,     dest = dest.CENTRAL_LANDING }, -- 16:05 Need this to close the loop

    },
    [xi.barge.location.CENTRAL_LANDING] =
    {
        { time =  280, act = act.ARRIVE, dest = dest.SOUTH_LANDING }, -- 04:40 from South Landing - EMFEA
        { time =  310, act = act.DEPART, dest = dest.SOUTH_LANDING }, -- 05:10 to South Landing - Newtpool
        { time = 1160, act = act.ARRIVE, dest = dest.SOUTH_LANDING }, -- 19:20 from North Landing
        { time = 1190, act = act.DEPART, dest = dest.SOUTH_LANDING }, -- 19:50 to South Landing - Newtpool PM
        { time = 1720, act = act.ARRIVE, dest = dest.SOUTH_LANDING }, -- 04:40 Need this to close the loop
    },
    [xi.barge.location.SOUTH_LANDING] =
    {
        { time =   15, act = act.ARRIVE,     dest = dest.CENTRAL_LANDING_EMFEA }, -- 00:15 from Central Landing - EMFEA
        { time =   50, act = act.DEPART,     dest = dest.CENTRAL_LANDING_EMFEA }, -- 00:50 to Central Landing - EMFEA
        { time =  540, act = act.ARRIVE_OOS, dest = dest.NORTH_LANDING         }, -- 09:00 Arrive OOS
        { time =  547, act = act.DEPART_OOS, dest = dest.NORTH_LANDING         }, -- 09:07 Depart OOS
        { time =  575, act = act.ARRIVE,     dest = dest.NORTH_LANDING         }, -- 09:35 Arrive from North Landing
        { time =  610, act = act.DEPART,     dest = dest.NORTH_LANDING         }, -- 10:10 to North Landing - Main Canal
        { time = 1420, act = act.ARRIVE_OOS, dest = dest.CENTRAL_LANDING_EMFEA }, -- 23:40 Arrive OOS
        { time = 1427, act = act.DEPART_OOS, dest = dest.CENTRAL_LANDING_EMFEA }, -- 23:47 Depart OOS
        { time = 1455, act = act.ARRIVE,     dest = dest.CENTRAL_LANDING_EMFEA }, -- 24:15 Need this to close the loop

    },
    [xi.barge.location.BARGE] =
    {
        { time =   15, act = act.ARRIVE, route = dest.CENTRAL_LANDING_EMFEA }, -- 00:15 Arrive at South Landing to Central Landing
        { time =  280, act = act.ARRIVE, route = dest.SOUTH_LANDING         }, -- 04:40 Arrive at Central Landing to South Landing
        { time =  575, act = act.ARRIVE, route = dest.NORTH_LANDING         }, -- 09:35 Arrive at South Landing to North Landing
        { time = 1005, act = act.ARRIVE, route = dest.CENTRAL_LANDING       }, -- 16:45 Arrive at North Landing to Central Loading
        { time = 1160, act = act.ARRIVE, route = dest.SOUTH_LANDING         }, -- 19:20 Arrive at Central Landing to South Landing
        { time = 1455, act = act.ARRIVE, route = dest.CENTRAL_LANDING_EMFEA }, -- 00:15 Need this to close the loop
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

        if location == xi.barge.location.BARGE then
            local earthMins = math.ceil(earthSecs / 60)
            local gameHours = math.floor(gameMins / 60)
            player:startEvent(eventId, earthMins, gameHours, nextEvent.route)
        else
            player:startEvent(eventId, earthSecs, nextEvent.act, 0, nextEvent.dest)
        end
    else
        printf("[warning] bad location %i in xi.barge.timekeeperOnTrigger", location)
    end
end

xi.barge.aboard = function(player, triggerArea, isAboard)
    if verbose then
        printf("INFO: player aboard set [%s] [%i] [%s] in xi.barge.aboard", player:getName(), triggerArea, tostring(isAboard))
    end

    player:setCharVar("[barge]aboard", isAboard and triggerArea or 0)
end

xi.barge.onZoneIn = function(player)
    local zoneId = player:getZoneID()

    -- Zoning onto barge. set [barge]arrivalEventId based on schedule.
    if zoneId == xi.zone.PHANAUET_CHANNEL then
        local schedule = bargeSchedule[xi.barge.location.BARGE]
        local currentTime = VanadielHour() * 60 + VanadielMinute()
        local nextEvent = nil

        for i = 1, #schedule do
            if schedule[i].time > currentTime then
                nextEvent = schedule[i]
                break
            end
        end

        if nextEvent.route == dest.NORTH_LANDING then
            -- Arrival CS - 10 parked boat
            -- Arrival CS - 11 fly in to dock, no boat
            -- North landing departure CS - 16 on boat
            -- North landing CS 17 - player on dock - 13?
            player:setCharVar("[barge]arrivalEventId", 11)
        elseif
            nextEvent.route == dest.CENTRAL_LANDING or
            nextEvent.route == dest.CENTRAL_LANDING_EMFEA
        then
            -- CS38 dock fly in
            -- Central landing CS 39 - player on dock
            -- CS40 Central landing departure on boat
            -- CS41 Central landing on dock
            player:setCharVar("[barge]arrivalEventId", 38)
        elseif nextEvent.route == dest.SOUTH_LANDING then
            -- Arrival CS - 10 parked boat
            -- Arrival CS - 11 fly in to dock, no boat
            -- South landing departure CS - 14 on boat
            -- South landing CS 15 - player on dock - 12?
            player:setCharVar("[barge]arrivalEventId", 10)
        end

    -- zoning into carpenters landing. play the eventId stored in [barge]arrivalEventId.
    elseif zoneId == xi.zone.CARPENTERS_LANDING then
        local eventId = player:getCharVar("[barge]arrivalEventId")
        player:setCharVar("[barge]arrivalEventId", 0)

        if eventId > 0 then
            return eventId
        else
            player:setPos(6.509, -9.163, -819.333, 239)
            return -1
        end
    end

    if verbose then
        printf("INFO: [%s] [%i] [%s] in xi.barge.onZoneIn", player:getName(), zoneId, player:getCharVar("[barge]arrivalEventId"))
    end
end

xi.barge.onTransportEvent = function(player, transport)
    -- [xi.ki.ticketki] = { ticketVar, locationVar, north1, south2, central3, northNoticket1, southNoticket2, centralNoticket3 }
    local bargeTable =
    {
        [xi.ki.BARGE_MULTI_TICKET] = { "Multi_Barge_Ticket", "[barge]aboard", 16, 14, 40, 34, 33, 42 },
        [xi.ki.BARGE_TICKET]       = { "Barge_Ticket", "[barge]aboard", 16, 14, 40, 34, 33, 42 },
    }

    local zoneID = zones[player:getZoneID()]
    local aboard = player:getCharVar("[barge]aboard") -- returns triggerRegion
    local canride = 0

    if aboard > 0 then
        for ki, vars in pairs(bargeTable) do
            if player:hasKeyItem(ki) then -- Multi-ticket and Single Ticket
                local uses = player:getCharVar(vars[1]) -- Number of tickets
                if uses > 1 then -- Multi-ticket
                    player:messageSpecial(zoneID.text.LEFT_BILLET, 0, ki, uses - 1) -- Ticket Count -1 Message
                    player:setCharVar(vars[1], uses - 1) -- Set Char Var
                    player:startEvent(vars[aboard + 2]) -- Succeed Event
                    canride = 1 -- Skip Failure Catch
                    break
                elseif uses == 1 then -- Multi Ticket (last use) and Single Ticket
                    player:messageSpecial(zoneID.text.END_BILLET, 0, ki) -- End of Ticket Msg
                    player:setCharVar(vars[1], 0) -- Reset Char Var Just In Case
                    player:delKeyItem(ki) -- Del KI
                    player:startEvent(vars[aboard + 2]) -- Succeed Event
                    canride = 1 -- Skip Failure Catch
                    break
                end
            end
        end

        if canride == 0 then -- Failure Catch
            player:startEvent(bargeTable[aboard + 5]) -- Failure Event
        end
    end
end

-- Ticket Shops
xi.barge.ticketshopOnTrigger = function(player, eventId)
    player:setCharVar("currentticket", 0) -- Set ticket to 0 in case something breaks

    if
        player:hasKeyItem(xi.ki.BARGE_TICKET) and
        player:hasKeyItem(xi.ki.BARGE_MULTI_TICKET)
    then
        player:setCharVar("currentticket", 3)
    elseif  player:hasKeyItem(xi.ki.BARGE_MULTI_TICKET) then
        player:setCharVar("currentticket", 2)
    elseif player:hasKeyItem(xi.ki.BARGE_TICKET) then
        player:setCharVar("currentticket", 1)
    else
        player:setCharVar("currentticket", 0)
    end

    -- Params (KI1, KI2, Price of KI1, Price of KI2, Multiticket #s left, Which tickets does player have)
    player:startEvent(eventId, xi.ki.BARGE_TICKET, xi.ki.BARGE_MULTI_TICKET , 50, 300, player:getCharVar("Multi_Barge_Ticket"), player:getCharVar("currentticket"), 0, 4095) -- Start event
end

xi.barge.ticketshoponEventFinish = function(player, csid, option)
    local currentticket = player:getCharVar("currentticket")
    local numberticket = player:getCharVar("Multi_Barge_Ticket")

    -- Option 1: BARGE_TICKET
    -- Option 2: MULTI_TICKET
    if
        csid == 31 or
        csid == 32 or
        csid == 43
    then
        if option == 1 and (currentticket == 1 or currentticket == 3) then -- If you have BARGE_TICKET
            -- Event auto plays the correct message
        elseif option == 1 and (player:getGil() >= 50) then
            player:delGil(50)
            player:addKeyItem(xi.ki.BARGE_TICKET)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BARGE_TICKET)
            player:setCharVar("Barge_Ticket", 1)
        elseif
            option == 2 and
            (currentticket == 2 or currentticket == 3) and
            numberticket <= 9
        then -- If you have multi ticket with less than 9
            player:delGil(300)
            player:messageSpecial(ID.text.MTICKET_ADDED, xi.ki.BARGE_MULTI_TICKET, 10)
            player:setCharVar("Multi_Barge_Ticket", 10)
        elseif option == 2 and player:getGil() >= 300 then
            player:delGil(300)
            player:addKeyItem(xi.ki.BARGE_MULTI_TICKET)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BARGE_MULTI_TICKET)
            player:setCharVar("Multi_Barge_Ticket", 10)
        else
            -- Event auto plays the correct message
        end
    end
end

xi.barge.onRouteStart = function(transportZone)
    -- set stage with relevant npc's for the route and questlines
    if verbose then
        printf("INFO: [%s] [%i] in xi.barge.onRouteStart", transportZone, VanadielHour() * 60 + VanadielMinute())
    end
end

xi.barge.onRouteEnd = function(transportZone)
    -- clean stage of relevant npc's for the route and questlines
    -- clean up any mobs
    if verbose then
        printf("INFO: [%s] [%i] in xi.barge.onRouteEnd", transportZone, VanadielHour() * 60 + VanadielMinute())
    end
end

xi.barge.onRouteUpdate = function(transportZone, tripTime)
    -- npc's should have their own hook for this to say their lines per route
    -- setup for pop window (ie. Stubborn Dredvodd)
    -- TODO: find the cut scene id for the Dredvodd pop
    if verbose then
        printf("INFO: [%s] [%i] [%i] in xi.barge.onRouteUpdate", transportZone, VanadielHour() * 60 + VanadielMinute(), tripTime)
    end
end

------------------------------------
-- Phanauet Channel
-- https://ffxiclopedia.fandom.com/wiki/Phanauet_Channel
--
-- code modified from Manaclipper
--
------------------------------------
-- cut scenes
------------------------------------
-- 10 - arrival parked boat
-- 11 - arrival fly in to dock, no boat
-- 12 - player on dock ?
-- 13 - player on dock ?
-- 14 - south landing departure on boat
-- 15 - south landing on dock
-- 16 - north landing departure on boat
-- 17 - north landing on dock
-- 18 - Chuaie - south landing
-- 19 - Ratoulle - central landing
-- 20 - Felourie - north landing

-- 33 - knocked out for no barge ticket - South
-- 34 - knocked out for no barge ticket - North
-- 42 - knocked out for no barge ticket - Central

-- 38 - central landing dock fly in
-- 39 - central landing player on dock
-- 40 - central landing departure on boat
-- 41 - central landing on dock

------------------------------------
local ID = require("scripts/zones/Carpenters_Landing/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/zone")
------------------------------------

xi = xi or {}
xi.barge = xi.barge or {}

-- set true for debug output
local verbose = false

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
    NORTH_LANDING         = 0, -- North Landing via the main canal
    SOUTH_LANDING         = 1, -- South Landing via the main canal
    CENTRAL_LANDING       = 2, -- Central Landing via the main canal
    CENTRAL_LANDING_EMFEA = 3, -- Central Landing via Emfea Waterway
}

-- Locations for timekeeper NPCs
xi.barge.location =
{
    NORTH_LANDING    = 0,
    SOUTH_LANDING    = 1,
    CENTRAL_LANDING  = 2,
    BARGE            = 3,
}

local bargeSchedule =
{
    [xi.barge.location.NORTH_LANDING] =
    {
        { time =  960, act = act.ARRIVE_OOS, dest = dest.CENTRAL_LANDING }, -- 16:00 Arrive OOS (Confirmed)
        { time =  970, act = act.DEPART_OOS, dest = dest.CENTRAL_LANDING }, -- 16:10 Depart OOS (Confirmed)
        { time = 1005, act = act.ARRIVE    , dest = dest.CENTRAL_LANDING }, -- 16:45 to Central (Confirmed)
        { time = 1045, act = act.DEPART    , dest = dest.CENTRAL_LANDING }, -- 17:25 to Centrel (Confirmed)
    },
    [xi.barge.location.CENTRAL_LANDING] =
    {
        { time =  275, act = act.ARRIVE, dest = dest.SOUTH_LANDING }, -- 04:35 from South Landing - EMFEA (confirmed)
        { time =  310, act = act.DEPART, dest = dest.SOUTH_LANDING }, -- 05:10 to South Landing - Newtpool (Confirmed)
        { time = 1155, act = act.ARRIVE, dest = dest.SOUTH_LANDING }, -- 19:15 from North Landing
        { time = 1190, act = act.DEPART, dest = dest.SOUTH_LANDING }, -- 19:50 to South Landing - Newtpool PM
    },
    [xi.barge.location.SOUTH_LANDING] =
    {
        { time =   15, act = act.ARRIVE    , dest = dest.CENTRAL_LANDING_EMFEA }, -- 00:15 from Central Landing - EMFEA (Confirmed)
        { time =   50, act = act.DEPART    , dest = dest.CENTRAL_LANDING_EMFEA }, -- 00:50 to Central Landing - EMFEA (Confirmed)
        -- 3 Different NPCs
        -- Riche "..."
        -- Eunirage "<Sigh> Are we there yet?" when talking
        -- Laiteconce (Timer person)

        { time =  535, act = act.ARRIVE_OOS, dest = dest.NORTH_LANDING         }, -- 08:55 Arrive OOS (Confirmed)
        { time =  545, act = act.DEPART_OOS, dest = dest.NORTH_LANDING         }, -- 09:05 Depart OOS (Confirmed)
        { time =  575, act = act.ARRIVE    , dest = dest.NORTH_LANDING         }, -- 09:35 Arrive for North Landing (Confirmed)
        { time =  610, act = act.DEPART    , dest = dest.NORTH_LANDING         }, -- 10:10 to North Landing - Main Canal (Confirmed)
        { time = 1415, act = act.ARRIVE_OOS, dest = dest.CENTRAL_LANDING_EMFEA }, -- 23:35 Arrive OOS (Confirmed)
        { time = 1425, act = act.DEPART_OOS, dest = dest.CENTRAL_LANDING_EMFEA }, -- 23:45 Depart OOS (Confirmed)

    },
    [xi.barge.location.BARGE] =
    {
        { time =   15, act = act.ARRIVE, route = dest.CENTRAL_LANDING_EMFEA }, -- 00:15 Central Landing
        { time =  275, act = act.ARRIVE, route = dest.SOUTH_LANDING         }, -- 04:35 Central Landing
        { time =  575, act = act.ARRIVE, route = dest.NORTH_LANDING         }, -- 09:35 South Landing
        { time = 1005, act = act.ARRIVE, route = dest.CENTRAL_LANDING       }, -- 16:45 North Landing
        { time = 1155, act = act.ARRIVE, route = dest.SOUTH_LANDING         }, -- 19:15 Central Landing
    },
}

local bargeTable =
{
    -- [xi.ki.ticketki] = {ticketVar, locationVar, validRegion1, validRegion2, validRegion3, invalidRegion1, invalidRegion2, invalidRegion3}
    [xi.ki.BARGE_MULTI_TICKET] = { "Barrge_Ticket", "[barge]aboard", 16, 14, 40, 34, 33, 42 },
    [xi.ki.BARGE_TICKET] = { "Barrge_Ticket", "[barge]aboard", 16, 14, 40, 34, 33, 42 },
}

-- Works 100%
xi.barge.timekeeperOnTrigger = function(player, location, eventId)
    if verbose then
        printf("INFO: [%i] [%i] in xi.barge.timekeeperOnTrigger, location, eventID")
    end
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

xi.barge.aboard = function(player, regionId, isAboard)
    player:setCharVar("[barge]aboard", isAboard and regionId or 0)
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
            player:setCharVar("[barge]arrivalEventId", 11) --
        elseif nextEvent.route == dest.CENTRAL_LANDING then
            -- CS38 dock fly in
            -- Central landing CS 39 - player on dock
            -- CS40 Central landing departure on boat
            -- CS41 Central landing on dock
            player:setCharVar("[barge]arrivalEventId", 38) --
        elseif nextEvent.route == dest.SOUTH_LANDING then
            -- Arrival CS - 10 parked boat
            -- Arrival CS - 11 fly in to dock, no boat
            -- South landing departure CS - 14 on boat
            -- South landing CS 15 - player on dock - 12?
            player:setCharVar("[barge]arrivalEventId", 10) --
        end

    -- zoning into carpenters landing. play the eventId stored in [barge]arrivalEventId.
    elseif zoneId == xi.zone.CARPENTERS_LANDING then
        local eventId = player:getCharVar("[barge]arrivalEventId")
        player:setCharVar("[barge]arrivalEventId", 0)

        if eventId > 0 then
            return eventId
        else
             player:setPos(669.917, -23.138, 911.655, 111)
            return -1
        end
    end
end

xi.barge.onTransportEvent = function(player, transport)
    local ID = zones[player:getZoneID()]
    local region = player:getCurrentRegion()
    local hasCS = 0

    for ki, vars in pairs(bargeTable) do
        -- if player:getGMLevel() >= 2 then
        --     player:startEvent(vars[region + 2]) -- Succeed Event
        --     hasCS = 1 -- Skip Failure Catch
        --     break
        if player:hasKeyItem(ki) then -- Multi-ticket and Single Ticket
            local uses = player:getCharVar(vars[1])
            if uses > 1 then -- Multi-ticket
                player:messageSpecial(ID.text.LEFT_BILLET, 0, ki, uses - 1) -- Ticket Count -1 Message
                player:setCharVar(vars[1], uses - 1) -- Set Char Var
                player:startEvent(vars[region + 2]) -- Succeed Event
                hasCS = 1 -- Skip Failure Catch
                break
            elseif uses == 1 then -- Multi Ticket (last use) and Single Ticket
                player:messageSpecial(ID.text.END_BILLET, 0, ki) -- End of Ticket Msg
                player:setCharVar(vars[1], 0) -- Reset Char Var Just In Case
                player:delKeyItem(ki) -- Del KI
                player:startEvent(vars[region + 2]) -- Succeed Event
                hasCS = 1 -- Skip Failure Catch
                break
            end
        end
    end

    if hasCS == 0 then -- Failure Catch
        player:startEvent(bargeTable[region + 5]) -- Failure Event
    end

end

-- xi.barge.onTransportEvent = function(player, transport)
--     local ID = zones[player:getZoneID()]
--     local aboard = player:getCharVar("[barge]aboard")
--     local canride = false

--     if aboard > 0 then
--         if player:hasKeyItem(xi.ki.ALLYOUCANRIDEPASS) then
--             -- GM only KI
--             canride = true
--         elseif player:hasKeyItem(xi.ki.BARGE_TICKET) then
--             player:delKeyItem(xi.ki.BARGE_TICKET)
--             canride = true
--         elseif player:hasKeyItem(xi.ki.BARGE_MULTI_TICKET) then
--             local uses = player:getCharVar("Barge_Ticket")

--             if uses == 1 then
--                 player:messageSpecial(ID.text.END_BILLET, 0, xi.ki.BARGE_MULTI_TICKET)
--                 player:delKeyItem(xi.ki.BARGE_MULTI_TICKET)
--             else
--                 player:messageSpecial(ID.text.LEFT_BILLET, 0, xi.ki.BARGE_MULTI_TICKET, uses - 1)
--             end
--             player:setCharVar("Barge_Ticket", uses - 1)
--             canride = true
--         else
--             canride = false
--         end
--     end

-- --[[    if verbose then
--         printf("INFO: [%s] [%s] [%s] [%s] in xi.barge.onTransportEvent", player:getName(), aboard, tostring(canride), player:getCharVar("Barge_Ticket"))
--     end]]

--     -- leaving North Landing. must be standing in region 1. must have a ticket.
--     if aboard == 1 then
--         if canride then
--             player:startEvent(16)
--         else
--             player:startEvent(34)
--         end
--         -- leaving South Landing. must be standing in region 2. must have a ticket.
--     elseif aboard == 2 then
--         if canride then
--             player:startEvent(14)
--         else
--             player:startEvent(33)
--         end
--         -- leaving Central Landing. must be standing in region 3. must have a ticket.
--     elseif aboard == 3 then
--         if canride then
--             player:startEvent(40)
--         else
--             player:startEvent(42)
--         end
--     end

-- end

-- xi.barge.ticketshopOnTrigger = function(player, eventId)
--     local currentticket = player:getLocalVar("currentticket")
--     local gils = player:getGil()
--     local ticketsleft = player:getCharVar("Barge_Ticket")

--     local ticketVars = {z
--         [xi.ki.BARGE_TICKET] = 1,
--         [xi.ki.BARGE_MULTI_TICKET] = 2,
--     }

--     -- For loop   for _, ticket in pairs([ticketVars])
--     if player:hasKeyItem(xi.ki.BARGE_TICKET) then
--         player:setLocalVar("currentticket", 1)
--     end

--     if player:hasKeyItem(xi.ki.BARGE_MULTI_TICKET) then
--         player:setLocalVar("currentticket", 2)
--     end

--     if player:hasKeyItem(xi.ki.BARGE_TICKET) and player:hasKeyItem(xi.ki.BARGE_MULTI_TICKET) then
--         player:setLocalVar("currentticket", 3)
--     end

--     -- Params (KI1, KI2, Price of KI1, Price of KI2, Multiticket #s left, Which tickets does player have)
--     player:startEvent(eventId, xi.ki.BARGE_TICKET, xi.ki.BARGE_MULTI_TICKET , 50, 300, ticketsleft, currentticket, 0, 4095)
-- end

xi.barge.ticketshopOnTrigger = function(player, eventId)
    local ticketInformation =
    {
        -- {ki, ki2, currentTicket, ticketVal, gil, maxTickets},
        { xi.ki.BARGE_TICKET,        xi.ki.BARGE_MULTI_TICKET, "currentTicket", 3, player:getGil(), "Barge_Ticket" },
        { xi.ki.BARGE_TICKET,        nil,                      "currentTicket", 1, player:getGil(), "Barge_Ticket" },
        { xi.ki.BARGE_MULTI_TICKET,  nil,                      "currentTicket", 2, player:getGil(), "Barge_Ticket" },
        { nil,                       nil,                      "currentTicket", 0, player:getGil(), "Barge_Ticket" },
    }
    print(ticket)
    for it, ticket in pairs(ticketInformation) do
        print("enter loop")
        if ticket[2] ~= nil and player:hasKeyItem(ticket[1]) and player:hasKeyItem(ticket[2]) then -- Has both KI
            player:setLocalVar(ticket[3], ticket[4]) -- Set currentTicket
        elseif player:hasKeyItem(ticket[1]) and it >= 2 then -- Has only 1 KI
            player:setLocalVar(ticket[3], ticket[4]) -- Set currentTicket
        end
        -- Params (KI1, KI2, Price of KI1, Price of KI2, Multiticket #s left, Which tickets does player have)
        if player:getLocalVar(ticket[3]) ~= 0 then -- Only executes if we set currentTicket
            return player:startEvent(eventId, xi.ki.BARGE_TICKET, xi.ki.BARGE_MULTI_TICKET , 50, 300, player:getCharVar(ticket[6]), player:getLocalVar(ticket[3]), 0, 4095) -- Start event and stop the loop so we don't trigger more than 1 event.
        elseif player:getLocalVar(ticket[3]) == 0 then -- If no ticket
            return player:startEvent(eventId, xi.ki.BARGE_TICKET, xi.ki.BARGE_MULTI_TICKET , 50, 300, player:getCharVar(ticket[6]), player:getLocalVar(ticket[3]), 0, 4095) -- Start event and stop the loop if we do not have any KI.
        end
        -- print(player:getLocalVar("currentTicket"))
    end
end

-- xi.barge.ticketshoponEventFinish = function(player, csid, option)
--     local currentticket = player:getLocalVar("currentticket")
--     local numberticket = player:getCharVar("Barge_Ticket")

--     if (csid == 31 or csid == 32 or csid == 43) then

--         if option==1 and currentticket == 1 then
--             player:messageSpecial(ID.text.HAVE_BILLET, xi.ki.BARGE_TICKET)
--         elseif option==1 and (player:getGil() >= 50) then
--             player:delGil(50)
--             player:addKeyItem(xi.ki.BARGE_TICKET)
--             player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BARGE_TICKET)
--         elseif option==2 and (currentticket == 2 or currentticket == 3) and numberticket <= 9 then
--             player:delGil(300)
--             player:messageSpecial(ID.text.MTICKET_ADDED, xi.ki.BARGE_MULTI_TICKET, 10)
--             player:setCharVar("Barge_Ticket", 10)
--         elseif option==2 and player:getGil() >= 300 then
--             player:delGil(300)
--             player:addKeyItem(xi.ki.BARGE_MULTI_TICKET)
--             player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BARGE_MULTI_TICKET)
--             player:setCharVar("Barge_Ticket", 10)
--         else
--             player:messageSpecial(ID.text.NO_GIL)
--         end
--     end
-- end

xi.barge.ticketshoponEventFinish = function(player, csid, option)
    local csInfo =
    {
        -- {csid1, csid2, csid3, option, message, ki, gil, cost, currentTicket, Barge_Ticket, maxTickets, ticketTrigger},
        { 31, 32, 43, 1, ID.text.HAVE_BILLET     , xi.ki.BARGE_TICKET      , player:getGil(), nil, "currentTicket", "Barge_Ticket", nil, 0 },
        { 31, 32, 43, 1, ID.text.KEYITEM_OBTAINED, xi.ki.BARGE_TICKET      , player:getGil(), 50 , "currentTicket", "Barge_Ticket", nil, 0 },
        { 31, 32, 43, 2, ID.text.KEYITEM_OBTAINED, xi.ki.BARGE_MULTI_TICKET, player:getGil(), 300, "currentTicket", "Barge_Ticket", 10 , 0 },
        { 31, 32, 43, 2, ID.text.MTICKET_ADDED   , xi.ki.BARGE_MULTI_TICKET, player:getGil(), 300, "currentTicket", "Barge_Ticket", 10 , 9 },
    }

    for _, cs in pairs(csInfo) do
        if (csid == cs[1] or csid == cs[2] or csid == cs[3]) and option == cs[4] then -- Select correct CS and option
            if cs[7] >= cs[8] and cs[9] ~= 1 and player:getCharVar(cs[10]) <= cs[12] then -- Does player meet requirements for 2 -> 4
                player:delGil(cs[8]) -- Delete Gil
                if cs[5] == ID.text.KEYITEM_OBTAINED then player:addKeyItem(cs[6]) end -- If KI added, add KI
                if cs[11] ~= nil then player:setCharVar(cs[10], cs[11]) end -- Set max tickets if needed
                return player:messageSpecial(cs[5], cs[6]) -- Provide appropriate message
            elseif cs[9] == 1 then -- Cannot buy a ticket
                return player:messageSpecial(cs[5], cs[6]) -- Provide appropriate message
            elseif cs[7] <= cs [8] then
                return player:messageSpecial(ID.text.NO_GIL)
            end

        end
        -- return player:messageSpecial(ID.text.NO_GIL)
    end

end

xi.barge.onRouteStart = function(transportZone)
    -- set stage with relevant npc's for the route and questlines
    if verbose then
        printf("INFO: [%s] [%i] in xi.barge.onRouteStart", transportZone,VanadielHour() * 60 + VanadielMinute())
    end
end

xi.barge.onRouteEnd = function(transportZone)
    -- clean stage of relevant npc's for the route and questlines
    -- clean up any mobs
    if verbose then
        printf("INFO: [%s] [%i] in xi.barge.onRouteEnd", transportZone,VanadielHour() * 60 + VanadielMinute())
    end
end

xi.barge.onRouteUpdate = function(transportZone, tripTime)
    -- npc's should have their own hook for this to say their lines per route
    -- setup for pop window (ie. Stubborn Dredvodd)
    -- TODO: find the cut scene id for the Dredvodd pop
    if verbose then
        printf("INFO: [%s] [%i] [%i] in xi.barge.onRouteUpdate", transportZone,VanadielHour() * 60 + VanadielMinute(), tripTime)
    end
end
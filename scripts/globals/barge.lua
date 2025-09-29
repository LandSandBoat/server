-----------------------------------
-- Carpenters' Landing Barge
-- https://www.bg-wiki.com/ffxi/Phanauet_Channel
-- TODO timed npc messages:
--      - When a barge arrives (not onTransportEvent, earlier than that)
--      - various chats while the barge goes up/down the river
-----------------------------------
xi = xi or {}
xi.barge = xi.barge or {}

-- OOS = out of service
-- ARRIVE action is given until the boat has fully docked
-- DEPART action is given until the boat has fully disppaered in the distance
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

-- times are minutes past midnight, since the cycle is every 1440 minutes, and aligns with the transports.sql entries
-- time for arrivalStart: time_offset
-- time for arrivalEnd:   time_offset + time_anim_arrive
-- time for departStart:  time_offset + time_anim_arrive + time_waiting
-- time for departEnd:    time_offset + time_anim_arrive + time_waiting + time_anim_depart
-- time for ride in the channel to end: time_offset + time_anim_arrive - 10
local bargeSchedule =
{
    [xi.barge.location.NORTH_LANDING] =
    {
        { endTime = utils.timeStringToMinutes('16:00'), action = actions.ARRIVE_OOS, route = destinations.CENTRAL_LANDING },
        { endTime = utils.timeStringToMinutes('16:21'), action = actions.DEPART_OOS, route = destinations.CENTRAL_LANDING },
        { endTime = utils.timeStringToMinutes('16:45'), action = actions.ARRIVE, route = destinations.CENTRAL_LANDING },
        { endTime = utils.timeStringToMinutes('17:40'), action = actions.DEPART, route = destinations.CENTRAL_LANDING },
    },
    [xi.barge.location.CENTRAL_LANDING] =
    {
        { endTime = utils.timeStringToMinutes('04:35'), action = actions.ARRIVE, route = destinations.SOUTH_LANDING },
        { endTime = utils.timeStringToMinutes('05:25'), action = actions.DEPART, route = destinations.SOUTH_LANDING },
        { endTime = utils.timeStringToMinutes('19:15'), action = actions.ARRIVE, route = destinations.SOUTH_LANDING },
        { endTime = utils.timeStringToMinutes('20:05'), action = actions.DEPART, route = destinations.SOUTH_LANDING },
    },
    [xi.barge.location.SOUTH_LANDING] =
    {
        { endTime = utils.timeStringToMinutes('00:15'), action = actions.ARRIVE, route = destinations.CENTRAL_LANDING_EMFEA },
        { endTime = utils.timeStringToMinutes('01:05'), action = actions.DEPART, route = destinations.CENTRAL_LANDING_EMFEA },
        { endTime = utils.timeStringToMinutes('08:55'), action = actions.ARRIVE_OOS, route = destinations.NORTH_LANDING },
        { endTime = utils.timeStringToMinutes('09:06'), action = actions.DEPART_OOS, route = destinations.NORTH_LANDING },
        { endTime = utils.timeStringToMinutes('09:35'), action = actions.ARRIVE, route = destinations.NORTH_LANDING },
        { endTime = utils.timeStringToMinutes('10:25'), action = actions.DEPART, route = destinations.NORTH_LANDING },
        { endTime = utils.timeStringToMinutes('23:35'), action = actions.ARRIVE_OOS, route = destinations.CENTRAL_LANDING_EMFEA },
        { endTime = utils.timeStringToMinutes('23:56'), action = actions.DEPART_OOS, route = destinations.CENTRAL_LANDING_EMFEA },
    },
    [xi.barge.location.PHANAUET_CHANNEL] =
    {
        { endTime = utils.timeStringToMinutes('04:35'), route = destinations.CENTRAL_LANDING_EMFEA },
        { endTime = utils.timeStringToMinutes('08:55'), route = destinations.SOUTH_LANDING },
        { endTime = utils.timeStringToMinutes('16:00'), route = destinations.NORTH_LANDING },
        { endTime = utils.timeStringToMinutes('19:15'), route = destinations.CENTRAL_LANDING },
        { endTime = utils.timeStringToMinutes('23:35'), route = destinations.SOUTH_LANDING },
    },
}

local getNextEvent = function(currentTime, schedule)
    local nextEvent = schedule[1]
    if
        schedule[#schedule].endTime <= currentTime or -- currentTime after the last event
        schedule[1].endTime > currentTime             -- currentTime before first event
    then
        -- next event is first of the day
        return schedule[1]
    end

    local prevEventEndTime = 0
    for i, currEvent in ipairs(schedule) do
        if
            prevEventEndTime <= currentTime and
            currEvent.endTime > currentTime
        then
            nextEvent = currEvent

            break
        end

        prevEventEndTime = currEvent.endTime
    end

    return nextEvent
end

xi.barge.timekeeperOnTrigger = function(player, location, eventId)
    local schedule = bargeSchedule[location]

    if not schedule then
        printf('[warning] bad location %i in xi.barge.timekeeperOnTrigger', location)

        return
    end

    local currentTime = VanadielHour() * 60 + VanadielMinute()
    local nextEvent = getNextEvent(currentTime, schedule)

    local gameMins = nextEvent.endTime - currentTime
    if nextEvent.endTime < currentTime then
        -- next event is before current time because it's near the end of the day, add a cycle
        -- nextEvent.endTime - currentTime underflows so add 1440 first
        gameMins = 1440 + nextEvent.endTime - currentTime
    end

    local earthSecs = gameMins * 60 / 25 -- one earth second is 25 game seconds

    if location == xi.barge.location.PHANAUET_CHANNEL then
        -- earthSecs is passed to dock timekeepers and they floor to report minutes, do the same here
        local earthMins = math.floor(earthSecs / 60)
        local gameHours = math.floor(gameMins / 60)
        if earthMins ~= 0 then
            player:startEvent(eventId, earthMins, gameHours, nextEvent.route)
        else
            -- arriving shortly
            player:startEvent(eventId - 1, 0, 0, nextEvent.route)
        end
    else
        player:startEvent(eventId, earthSecs, nextEvent.action, 0, nextEvent.route)
    end
end

-- defines which NPCs to display for a route
-- # is the offset from each ID.npc entry
local npcList =
{
    [destinations.NORTH_LANDING] =
    {
        -- Roi, Luquillaue, Ineuteniace
        tonberry = 1,
        timekeeper = 0,
        rider = 1,
    },
    [destinations.CENTRAL_LANDING] =
    {
        -- Roi, Luquillaue, Eunirange
        tonberry = 1,
        timekeeper = 1,
        rider = 1,
    },
    [destinations.SOUTH_LANDING] =
    {
        -- Riche, Laiteconce, Ineuteniace
        tonberry = 0,
        timekeeper = 0,
        rider = 0,
    },
    [destinations.CENTRAL_LANDING_EMFEA] =
    {
        -- Riche, Laiteconce, Eunirange
        tonberry = 0,
        timekeeper = 1,
        rider = 0,
    },
}

local handleEntityVisibility = function(destination, zoneId)
    local zone = GetZone(zoneId)
    -- offset by one to avoid zero
    if not zone or zone:getLocalVar('destinationEntities') == destination + 1 then
        return
    end

    zone:setLocalVar('destinationEntities', destination + 1)
    local ID = zones[zone:getID()]
    local npcData = npcList[destination]
    if not npcData then
        -- should not be possible
        return
    end

    local offsets =
    {
        tonberry = ID.npc.TONBERRY_OFFSET,
        timekeeper = ID.npc.TIMEKEEPER_OFFSET,
        rider = ID.npc.RIDER_OFFSET,
    }

    for k, v in pairs(npcData) do
        for i = 0, 1 do
            local npc = GetNPCByID(offsets[k] + i)
            if npc then
                if v == i then
                    npc:setStatus(xi.status.NORMAL)
                else
                    npc:setStatus(xi.status.DISAPPEAR)
                end
            end
        end
    end
end

local dockEventData =
{
    [destinations.NORTH_LANDING] =
    {
        -- transport ids from DB
        transports = { 25 },
        arrivalCsId = 11,
        arrivalPos =
        {
            x = -303.166, y = -1.971, z = 504.964, rotation = 96,
        },
        departEvent = 16,
        kickEvent = 34,
        triggerAreaId = 1,
    },
    [destinations.CENTRAL_LANDING] =
    {
        -- transport ids from DB
        transports = { 21, 26 },
        arrivalCsId = 10,
        arrivalPos =
        {
            x = -137.275, y = -1.964, z = 60.265, rotation = 96,
        },
        departEvent = 40,
        kickEvent = 42,
        triggerAreaId = 3,
    },
    [destinations.SOUTH_LANDING] =
    {
        -- transport ids from DB
        transports = { 20, 23 },
        arrivalCsId = 38,
        arrivalPos =
        {
            x = 230.621, y = -1.987, z = -530.240, rotation = 129
        },
        departEvent = 14,
        kickEvent = 33,
        triggerAreaId = 2,
    },
}

xi.barge.onZoneIn = function(player, prevZone)
    local zoneId = player:getZoneID()

    if zoneId == xi.zone.PHANAUET_CHANNEL then
        -- Zoning into Phanauet Channel. Set destination charvar based on schedule.
        local schedule = bargeSchedule[xi.barge.location.PHANAUET_CHANNEL]
        local currentTime = VanadielHour() * 60 + VanadielMinute()
        local nextEvent = getNextEvent(currentTime, schedule)

        -- Saving as a charvar for use when zoning back into carpenter's landing
        -- TODO should we reset the charvar to negative 1 when leaving a dock and only set this if the charvar is -1? This would block skipping legs by logging out
        player:setCharVar('[barge]destinationDockId', nextEvent.route)

        -- entity visibility only matters if a player zones in, set it now
        handleEntityVisibility(nextEvent.route, player:getZoneID())
    elseif
        zoneId == xi.zone.CARPENTERS_LANDING and
        prevZone == xi.zone.PHANAUET_CHANNEL
    then
        -- Zoning into Carpenter's Landing. Play the cs saved when we started the ride.
        local bargeDestinationId = player:getCharVar('[barge]destinationDockId')
        player:setCharVar('[barge]destinationDockId', 0)

        -- get destinationData with failback to destinations.CENTRAL_LANDING in case of mangled data or route == destinations.CENTRAL_LANDING_EMFEA
        local bargeDestinationData = dockEventData[bargeDestinationId] or dockEventData[destinations.CENTRAL_LANDING]
        player:setPos(bargeDestinationData.arrivalPos)

        return { bargeDestinationData.arrivalCsId, -1, bit.bor(xi.cutsceneFlag.UNKNOWN_1, xi.cutsceneFlag.NO_PCS) }
    end

    return -1
end

xi.barge.onTransportEvent = function(player, zoneId, transportId)
    local aboard   = player:getLocalVar('[barge]aboard')
    local destData = nil

    for _, bargeDestinationData in pairs(dockEventData) do
        if bargeDestinationData.triggerAreaId == aboard then
            destData = bargeDestinationData

            break
        end
    end

    if destData == nil then -- was not in trigger area for the transport event
        return -1
    end

    if not utils.contains(transportId, destData.transports) then
        -- Normal game client won't let you enter the boat trigger area unless the boat is there, but check this transport event aligns with the schedule to avoid shenanigans

        -- was in trigger area but no in-service boat was departing from this dock
        player:startEvent(destData.kickEvent)
    elseif player:hasKeyItem(xi.ki.BARGE_TICKET) then
        -- This is technically done on event end but does not matter
        player:delKeyItem(xi.ki.BARGE_TICKET)

        player:startEvent(destData.departEvent,
            {
                [0] = 0,
                [1] = xi.ki.BARGE_TICKET,
                [2] = 0, -- Important to be set to 0
                flags = bit.bor(
                    xi.cutsceneFlag.UNKNOWN_1,
                    xi.cutsceneFlag.NO_PCS,
                    xi.cutsceneFlag.UNKNOWN_4,
                    xi.cutsceneFlag.UNKNOWN_7
                ),
            })
    elseif player:hasKeyItem(xi.ki.BARGE_MULTI_TICKET) then
        local usesLeft = player:getCharVar('[barge]multiTicket') - 1

        if usesLeft <= 0 then
            usesLeft = 0
            player:delKeyItem(xi.ki.BARGE_MULTI_TICKET)
        end

        player:setCharVar('[barge]multiTicket', usesLeft)
        -- was in trigger area and had a ticket
        player:startEvent(destData.departEvent,
            {
                [0] = usesLeft,     -- Not actually used by CS but passed in
                [1] = xi.ki.BARGE_MULTI_TICKET,
                [2] = usesLeft + 1, -- This expects the number of uses before it get decremented
                flags = bit.bor(
                    xi.cutsceneFlag.UNKNOWN_1,
                    xi.cutsceneFlag.NO_PCS,
                    xi.cutsceneFlag.UNKNOWN_4,
                    xi.cutsceneFlag.UNKNOWN_7
                ),
            })
    else
        -- was in trigger area but didn't have a ticket
        player:startEvent(destData.kickEvent)
    end
end

-- index is the event option from menu
local tickets =
{
    [1] =
    {
        keyItem = xi.ki.BARGE_TICKET,
        cost = 50,
    },

    [2] =
    {
        keyItem = xi.ki.BARGE_MULTI_TICKET,
        cost = 300,
        charges = 10,
    },
}

xi.barge.onTicketShopTrigger = function(player, eventId)
    local hasKeyItemParam = 0
    local numberTicket = player:getCharVar('[barge]multiTicket')
    for i, ticketData in pairs(tickets) do
        hasKeyItemParam = utils.mask.setBit(hasKeyItemParam, i - 1, player:hasKeyItem(ticketData.keyItem))
    end

    -- Params (KI1, KI2, Price of KI1, Price of KI2, Multiticket #s left, Which tickets does player have)
    player:startEvent(eventId, tickets[1].keyItem, tickets[2].keyItem, tickets[1].cost, tickets[2].cost, numberTicket, hasKeyItemParam, 0, 0)
end

xi.barge.onTicketShopEventFinish = function(player, csid, option, npc)
    local ID = zones[player:getZoneID()]
    local numberTicket = player:getCharVar('[barge]multiTicket')
    local ticketData = tickets[option]

    if
        ticketData and
        (csid == 31 or
        csid == 32 or
        csid == 43)
    then
        local gil = player:getGil()
        -- Event auto plays the correct message if you have the KI (and multi at max charges)
        if
            not player:hasKeyItem(ticketData.keyItem) or
            (ticketData.charges and numberTicket < ticketData.charges)
        then
            if gil >= ticketData.cost then
                player:delGil(ticketData.cost)
                player:addKeyItem(ticketData.keyItem)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, ticketData.keyItem, ticketData.charges or 0)
                if ticketData.charges then
                    player:setCharVar('[barge]multiTicket', ticketData.charges)
                end
            else
                -- TODO find out the cs params to auto-detect not enough gil to avoid incorrect messaging
                -- the cs can automatically detect if the player doesn't have enough gil when choosing one to buy (passing no key item shows that): !cs 32 0 0 30 300
                local showName = true
                local turnToPlayer = false
                -- dynamically addresses based on gender, neat!
                player:showText(npc, ID.text.TOO_POOR, 0, 0, 0, 0, showName, turnToPlayer)
            end
        end
    end
end

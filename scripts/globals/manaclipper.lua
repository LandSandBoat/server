-----------------------------------
-- Manaclipper
-- https://www.bg-wiki.com/ffxi/Manaclipper
-- TODO timed npc messages:
--      - When a barge arrives (not onTransportEvent, earlier than that)
--      - various chats while the barge goes up/down the river
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

-- times are minutes past midnight, and aligns with the transports.sql entries.
-- Since the cycle is every 720 minutes, 2 cycles are listed for simpler logic
-- time for arrivalStart: time_offset
-- time for arrivalEnd:   time_offset + time_anim_arrive
-- time for departStart:  time_offset + time_anim_arrive + time_waiting
-- time for departEnd:    time_offset + time_anim_arrive + time_waiting + time_anim_depart
-- time for ride on the manaclipper to end: time_offset + time_anim_arrive - 10
local manaclipperSchedule =
{
    [xi.manaclipper.location.SUNSET_DOCKS] =
    {
        { endTime = utils.timeStringToMinutes('00:10'), act = act.ARRIVE, dest = dest.DHALMEL_ROCK },
        { endTime = utils.timeStringToMinutes('00:50'), act = act.DEPART, dest = dest.DHALMEL_ROCK },
        { endTime = utils.timeStringToMinutes('04:50'), act = act.ARRIVE, dest = dest.PURGONORGO_ISLE },
        { endTime = utils.timeStringToMinutes('05:30'), act = act.DEPART, dest = dest.PURGONORGO_ISLE },
        { endTime = utils.timeStringToMinutes('12:10'), act = act.ARRIVE, dest = dest.MALIYAKALEYA_REEF },
        { endTime = utils.timeStringToMinutes('12:50'), act = act.DEPART, dest = dest.MALIYAKALEYA_REEF },
        { endTime = utils.timeStringToMinutes('16:50'), act = act.ARRIVE, dest = dest.PURGONORGO_ISLE },
        { endTime = utils.timeStringToMinutes('17:30'), act = act.DEPART, dest = dest.PURGONORGO_ISLE },
    },

    [xi.manaclipper.location.PURGONORGO_ISLE] =
    {
        { endTime = utils.timeStringToMinutes('08:40'), act = act.ARRIVE, dest = dest.SUNSET_DOCKS },
        { endTime = utils.timeStringToMinutes('09:15'), act = act.DEPART, dest = dest.SUNSET_DOCKS },
        { endTime = utils.timeStringToMinutes('20:40'), act = act.ARRIVE, dest = dest.SUNSET_DOCKS },
        { endTime = utils.timeStringToMinutes('21:15'), act = act.DEPART, dest = dest.SUNSET_DOCKS },
    },

    [xi.manaclipper.location.MANACLIPPER] =
    {
        { endTime = utils.timeStringToMinutes('00:10'), route = dest.SUNSET_DOCKS },
        { endTime = utils.timeStringToMinutes('04:50'), route = dest.DHALMEL_ROCK },
        { endTime = utils.timeStringToMinutes('08:40'), route = dest.PURGONORGO_ISLE },
        { endTime = utils.timeStringToMinutes('12:10'), route = dest.SUNSET_DOCKS },
        { endTime = utils.timeStringToMinutes('16:50'), route = dest.MALIYAKALEYA_REEF },
        { endTime = utils.timeStringToMinutes('20:40'), route = dest.PURGONORGO_ISLE },
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

xi.manaclipper.timekeeperOnTrigger = function(player, location, eventId)
    local schedule = manaclipperSchedule[location]

    if not schedule then
        printf('[warning] bad location %i in xi.manaclipper.timekeeperOnTrigger', location)
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

    if location == xi.manaclipper.location.MANACLIPPER then
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
        player:startEvent(eventId, earthSecs, nextEvent.act, 0, nextEvent.dest)
    end
end

xi.manaclipper.onZoneIn = function(player, prevZone)
    local zoneId = player:getZoneID()

    -- zoning onto manaclipper. set [manaclipper]arrivalEventId based on schedule.
    if zoneId == xi.zone.MANACLIPPER then
        local schedule = manaclipperSchedule[xi.manaclipper.location.MANACLIPPER]
        local currentTime = VanadielHour() * 60 + VanadielMinute()
        local nextEvent = getNextEvent(currentTime, schedule)

        if nextEvent.route == dest.PURGONORGO_ISLE then
            player:setCharVar('[manaclipper]arrivalEventId', 13) -- Bibiki event 13 sets pos then chains to 11: arrive at Purgonorgo Isle
        else
            player:setCharVar('[manaclipper]arrivalEventId', 12) -- Bibiki event 12 sets pos then chains to 10: arrive at Sunset Docks
        end

    -- zoning into bibiki bay from the manaclipper. play the eventId stored in [manaclipper]arrivalEventId.
    elseif
        zoneId == xi.zone.BIBIKI_BAY and
        prevZone == xi.zone.MANACLIPPER
    then
        local eventId = player:getCharVar('[manaclipper]arrivalEventId')
        player:setCharVar('[manaclipper]arrivalEventId', 0)

        -- game client updates player's position
        if eventId == 13 then
            return 13
        else
            return 12
        end
    end

    return -1
end

xi.manaclipper.onTransportEvent = function(player, prevZoneId, transportId)
    local ID = zones[player:getZoneID()]
    local aboard = player:getLocalVar('[manaclipper]aboard')

    -- leaving Sunset Docks. must be standing in trigger area 1. must have a ticket.
    if aboard == 1 then
        if player:hasKeyItem(xi.ki.MANACLIPPER_TICKET) then
            player:delKeyItem(xi.ki.MANACLIPPER_TICKET)
            player:startEvent(14)
        elseif player:hasKeyItem(xi.ki.MANACLIPPER_MULTI_TICKET) then
            local uses = player:getCharVar('Manaclipper_Ticket') - 1

            if uses <= 0 then
                uses = 0
                player:messageSpecial(ID.text.END_BILLET, 0, xi.ki.MANACLIPPER_MULTI_TICKET)
                player:delKeyItem(xi.ki.MANACLIPPER_MULTI_TICKET)
            else
                player:messageSpecial(ID.text.LEFT_BILLET, 0, xi.ki.MANACLIPPER_MULTI_TICKET, uses)
            end

            player:setCharVar('Manaclipper_Ticket', uses)
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

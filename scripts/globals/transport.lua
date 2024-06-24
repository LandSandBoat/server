-----------------------------------
-- Transport
-----------------------------------
require('scripts/globals/pathfind')
-----------------------------------
xi = xi or {}
xi.transport = xi.transport or {}

xi.transport.message =
{
    NEARING = 0,
    DOCKING = 1
}

xi.transport.epochOffset =
{
    NEARING = 265,
    DOCKING = 290
}

xi.transport.messageTime =
{
    SILVER_SEA = 480
}

xi.transport.trigger =
{
    mhaura =
    {
        FERRY_ARRIVING_FROM_ALZAHBI = 0,
        FERRY_DEPARTING_TO_ALZAHBI  = 1,
        FERRY_ARRIVING_FROM_SELBINA = 2,
        FERRY_DEPARTING_TO_SELBINA  = 3
    },
    selbina =
    {
        FERRY_ARRIVING_FROM_MHAURA = 0,
        FERRY_DEPARTING_TO_MHAURA  = 1
    }
}

xi.transport.interval =
{
    mhaura =
    {
        FROM_TO_ALZAHBI = 480,
        FROM_TO_SELBINA = 480
    },
    selbina =
    {
        FROM_TO_MHAURA = 480
    }
}

xi.transport.offset =
{
    mhaura =
    {
        FERRY_ARRIVING_FROM_ALZAHBI = 159,
        FERRY_DEPARTING_TO_ALZAHBI  = 239,
        FERRY_ARRIVING_FROM_SELBINA = 399,
        FERRY_DEPARTING_TO_SELBINA  = 479
    },
    selbina =
    {
        FERRY_ARRIVING_FROM_MHAURA = 399,
        FERRY_DEPARTING_TO_MHAURA = 479
    }
}

xi.transport.pos =
{
    mhaura =
    {
        ARRIVING  =
        {
            { x = 7.06, y = -1.36, z = 2.20, rotation = 211 }
        },
        DEPARTING =
        {
            { x = 8.26, y = -1.36, z = 2.20, rotation = 193 }
        },
    },
    selbina =
    {
        ARRIVING  =
        {
            { x = 16.768, y = -1.38, z = -58.843, rotation = 209 }
        },
        DEPARTING =
        {
            { x = 17.979, y = -1.389, z = -58.800, rotation = 191 }
        },
    }
}

xi.transport.actions =
{
    ARRIVE = 0,
    DEPART = 1,
}

xi.transport.destinations =
{
    SELBINA  = 0,
    AL_ZAHBI = 1,
}

xi.transport.routes =
{
    SELBINA_MHAURA          = 0,
    OPEN_SEA                = 1,
    SILVER_SEA              = 2,
    SELBINA_MHAURA_OPEN_SEA = 3,
}

xi.transport.schedules =
{
    [xi.transport.routes.SELBINA_MHAURA] = -- Ship bound for [Mhaura/Selbina]
    {
        { time =    0, action = xi.transport.actions.DEPART }, -- 00:00
        { time =  400, action = xi.transport.actions.ARRIVE }, -- 06:40
        { time =  480, action = xi.transport.actions.DEPART }, -- 08:00
        { time =  880, action = xi.transport.actions.ARRIVE }, -- 14:40
        { time =  960, action = xi.transport.actions.DEPART }, -- 16:00
        { time = 1360, action = xi.transport.actions.ARRIVE }, -- 22:40
    },
    [xi.transport.routes.OPEN_SEA] = -- Open sea route to [Al Zahbi/Mhaura]
    {
        { time =  160, action = xi.transport.actions.ARRIVE }, -- 02:40
        { time =  240, action = xi.transport.actions.DEPART }, -- 04:00
        { time =  640, action = xi.transport.actions.ARRIVE }, -- 10:40
        { time =  720, action = xi.transport.actions.DEPART }, -- 12:00
        { time = 1120, action = xi.transport.actions.ARRIVE }, -- 18:40
        { time = 1200, action = xi.transport.actions.DEPART }, -- 20:00
    },
    [xi.transport.routes.SILVER_SEA] = -- Silver Sea route to [Al Zahbi/Nashmau]
    {
        { time =    0, action = xi.transport.actions.DEPART }, -- 00:00
        { time =  300, action = xi.transport.actions.ARRIVE }, -- 05:00
        { time =  480, action = xi.transport.actions.DEPART }, -- 08:00
        { time =  780, action = xi.transport.actions.ARRIVE }, -- 13:00
        { time =  960, action = xi.transport.actions.DEPART }, -- 16:00
        { time = 1260, action = xi.transport.actions.ARRIVE }, -- 21:00
    },
    [xi.transport.routes.SELBINA_MHAURA_OPEN_SEA] = -- Combination of Ship bound for [Mhaura/Selbina] and Open sea route to [Al Zahbi/Mhaura] used by Dieh Yamilsiah
    {
        { time =    0, action = xi.transport.actions.DEPART, destination = xi.transport.destinations.SELBINA },  -- 00:00
        { time =  160, action = xi.transport.actions.ARRIVE, destination = xi.transport.destinations.AL_ZAHBI }, -- 02:40
        { time =  240, action = xi.transport.actions.DEPART, destination = xi.transport.destinations.AL_ZAHBI }, -- 04:00
        { time =  400, action = xi.transport.actions.ARRIVE, destination = xi.transport.destinations.SELBINA },  -- 06:40
        { time =  480, action = xi.transport.actions.DEPART, destination = xi.transport.destinations.SELBINA },  -- 08:00
        { time =  640, action = xi.transport.actions.ARRIVE, destination = xi.transport.destinations.AL_ZAHBI }, -- 10:40
        { time =  720, action = xi.transport.actions.DEPART, destination = xi.transport.destinations.AL_ZAHBI }, -- 12:00
        { time =  880, action = xi.transport.actions.ARRIVE, destination = xi.transport.destinations.SELBINA },  -- 14:40
        { time =  960, action = xi.transport.actions.DEPART, destination = xi.transport.destinations.SELBINA },  -- 16:00
        { time = 1120, action = xi.transport.actions.ARRIVE, destination = xi.transport.destinations.AL_ZAHBI }, -- 18:40
        { time = 1200, action = xi.transport.actions.DEPART, destination = xi.transport.destinations.AL_ZAHBI }, -- 20:00
        { time = 1360, action = xi.transport.actions.ARRIVE, destination = xi.transport.destinations.SELBINA },  -- 22:40
    }
}

-----------------------------------
-- public functions
-----------------------------------

xi.transport.captainMessage = function(npc, triggerID, messages)
    local playersInZone = npc:getZone():getPlayers()
    for _, player in pairs(playersInZone) do
        player:showText(player, messages[triggerID])
    end
end

xi.transport.dockMessage = function(npc, triggerID, messages, dock)
    npc:showText(npc, messages[triggerID])
    if (triggerID % 2) == 0 then
        npc:pathThrough(xi.transport.pos[dock].ARRIVING, bit.bor(xi.path.flag.PATROL, xi.path.flag.WALLHACK))
    else
        npc:pathThrough(xi.transport.pos[dock].DEPARTING, bit.bor(xi.path.flag.PATROL, xi.path.flag.WALLHACK))
    end
end

xi.transport.onBoatTimekeeperTrigger = function(player, route, travelMessage, arrivingMessage)
    local schedule = xi.transport.schedules[route]

    if schedule then
        local nextEvent = xi.transport.getNextEvent(schedule, route)

        local message = travelMessage
        if nextEvent.gameMins < 30 then
            message = arrivingMessage
        end

        player:messageSpecial(message, nextEvent.earthMins, nextEvent.gameHours)
    else
        printf('[warning] bad location %i in xi.transport.onBoatTimekeeperTrigger', route)
    end
end

xi.transport.onDockTimekeeperTrigger = function(player, route, event)
    local schedule = xi.transport.schedules[route]

    if schedule then
        local nextEvent = xi.transport.getNextEvent(schedule, route)

        if route == xi.transport.routes.SELBINA_MHAURA_OPEN_SEA then
            player:startEvent(event, nextEvent.earthSecs, nextEvent.action, 0, nextEvent.destination)
        else
            player:startEvent(event, nextEvent.earthSecs, nextEvent.action)
        end
    else
        printf('[warning] bad location %i in xi.transport.onDockTimekeeperTrigger', route)
    end
end

xi.transport.getNextEvent = function(schedule, route)
    local currentTime = VanadielHour() * 60 + VanadielMinute()
    local nextEvent = nil

    for i = 1, #xi.transport.schedules[route] do
        if schedule[i].time > currentTime then
            nextEvent = schedule[i]
            break
        end
    end

    if nextEvent == nil then
        nextEvent = schedule[1]
        nextEvent.time = nextEvent.time + 1440 -- next day
    end

    nextEvent.gameMins = nextEvent.time - currentTime
    nextEvent.earthSecs = nextEvent.gameMins * 60 / 25 -- one earth second is 25 game seconds
    nextEvent.earthMins = math.ceil(nextEvent.earthSecs / 60)
    nextEvent.gameHours = math.floor(nextEvent.gameMins / 60)

    return nextEvent
end

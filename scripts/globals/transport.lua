-----------------------------------
-- Transport
-----------------------------------
require('scripts/globals/pathfind')
-----------------------------------
xi = xi or {}
xi.transport = xi.transport or {}

-----------------------------------
-- Enums
-----------------------------------
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
        FERRY_DEPARTING_TO_MHAURA  = 479
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

local direction =
{
    ARRIVE = 0,
    DEPART = 1,
}

local destination =
{
    MHAURA   = 0,
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

-----------------------------------
-- Tables
-----------------------------------
local dockTable =
{
    -- ['npc_name'] = { eventId, route },
    ['Baya_Hiramayuh' ] = { 232, xi.transport.routes.OPEN_SEA                }, -- Aht Urhgan Whitegate to Mhaura
    ['Dieh_Yamilsiah' ] = { 231, xi.transport.routes.SELBINA_MHAURA_OPEN_SEA }, -- Mhaura to Aht Urhgan Whitegate or Selbina
    ['Laughing_Bison' ] = { 333, xi.transport.routes.SELBINA_MHAURA_OPEN_SEA }, -- Mhaura to Aht Urhgan Whitegate or Selbina
    ['Humilitie'      ] = { 231, xi.transport.routes.SELBINA_MHAURA          }, -- Selbina to Mhaura
    ['Kuhn_Tsahnpri'  ] = { 236, xi.transport.routes.SILVER_SEA              }, -- Aht Urhgan Whitegate to Nashmau
    ['Yohj_Dukonlhy'  ] = { 231, xi.transport.routes.SILVER_SEA              }, -- Nashmau to Aht Urhgan Whitegate
}

local scheduleTable =
{
    [xi.transport.routes.SELBINA_MHAURA] = -- Ship bound for [Mhaura/Selbina]
    {
        [1] = { startTime =    0, endTime =  400, action = direction.ARRIVE, target = 0 },
        [2] = { startTime =  400, endTime =  480, action = direction.DEPART, target = 0 },
        [3] = { startTime =  480, endTime =  880, action = direction.ARRIVE, target = 0 },
        [4] = { startTime =  880, endTime =  960, action = direction.DEPART, target = 0 },
        [5] = { startTime =  960, endTime = 1360, action = direction.ARRIVE, target = 0 },
        [6] = { startTime = 1360, endTime = 1440, action = direction.DEPART, target = 0 },
    },

    [xi.transport.routes.OPEN_SEA] = -- Open sea route to [Al Zahbi/Mhaura]
    {
        [1] = { startTime =    0, endTime =  160, action = direction.ARRIVE, target = 0 },
        [2] = { startTime =  160, endTime =  240, action = direction.DEPART, target = 0 },
        [3] = { startTime =  240, endTime =  640, action = direction.ARRIVE, target = 0 },
        [4] = { startTime =  640, endTime =  720, action = direction.DEPART, target = 0 },
        [5] = { startTime =  720, endTime = 1120, action = direction.ARRIVE, target = 0 },
        [6] = { startTime = 1120, endTime = 1200, action = direction.DEPART, target = 0 },
        [7] = { startTime = 1200, endTime = 1600, action = direction.ARRIVE, target = 0 },
    },
    [xi.transport.routes.SILVER_SEA] = -- Silver Sea route to [Al Zahbi/Nashmau]
    {
        [1] = { startTime =    0, endTime =  300, action = direction.ARRIVE, target = 0 },
        [2] = { startTime =  300, endTime =  480, action = direction.DEPART, target = 0 },
        [3] = { startTime =  480, endTime =  780, action = direction.ARRIVE, target = 0 },
        [4] = { startTime =  780, endTime =  960, action = direction.DEPART, target = 0 },
        [5] = { startTime =  960, endTime = 1260, action = direction.ARRIVE, target = 0 },
        [6] = { startTime = 1260, endTime = 1440, action = direction.DEPART, target = 0 },
    },
    [xi.transport.routes.SELBINA_MHAURA_OPEN_SEA] = -- Combination of Ship bound for [Mhaura/Selbina] and Open sea route to [Al Zahbi/Mhaura] used by Dieh Yamilsiah
    {
        [ 1] = { startTime =    0, endTime =  160, action = direction.ARRIVE, target = destination.AL_ZAHBI },
        [ 2] = { startTime =  160, endTime =  240, action = direction.DEPART, target = destination.AL_ZAHBI },
        [ 3] = { startTime =  240, endTime =  400, action = direction.ARRIVE, target = destination.SELBINA  },
        [ 4] = { startTime =  400, endTime =  480, action = direction.DEPART, target = destination.SELBINA  },
        [ 5] = { startTime =  480, endTime =  640, action = direction.ARRIVE, target = destination.AL_ZAHBI },
        [ 6] = { startTime =  640, endTime =  720, action = direction.DEPART, target = destination.AL_ZAHBI },
        [ 7] = { startTime =  720, endTime =  880, action = direction.ARRIVE, target = destination.SELBINA  },
        [ 8] = { startTime =  880, endTime =  960, action = direction.DEPART, target = destination.SELBINA  },
        [ 9] = { startTime =  960, endTime = 1120, action = direction.ARRIVE, target = destination.AL_ZAHBI },
        [10] = { startTime = 1120, endTime = 1200, action = direction.DEPART, target = destination.AL_ZAHBI },
        [11] = { startTime = 1200, endTime = 1360, action = direction.ARRIVE, target = destination.SELBINA  },
        [12] = { startTime = 1360, endTime = 1440, action = direction.DEPART, target = destination.SELBINA  },
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

-----------------------------------
-- NPC functions
-----------------------------------
xi.transport.onBoatTimekeeperTrigger = function(player, route, travelMessage, arrivingMessage)
    local currentTime = VanadielHour() * 60 + VanadielMinute()
    local timeDiff    = 0

    for i = 1, #scheduleTable[route] do
        if
            currentTime >= scheduleTable[route][i].startTime and
            currentTime < scheduleTable[route][i].endTime
        then
            timeDiff = scheduleTable[route][i].endTime - currentTime

            break
        end
    end

    local message   = timeDiff < 30 and arrivingMessage or travelMessage
    local earthMins = math.ceil(timeDiff / 25)
    local gameHours = math.floor(timeDiff / 60)

    player:messageSpecial(message, earthMins, gameHours)
end

xi.transport.onDockTimekeeperTrigger = function(player, npc)
    -- Fetch NPC data.
    local npcName = npc:getName()
    local eventId = dockTable[npcName][1]
    local route   = dockTable[npcName][2]

    -- Fetch Schedule
    local currentTime  = VanadielHour() * 60 + VanadielMinute()
    local scheduleStep = 0

    for i = 1, #scheduleTable[route] do
        if
            currentTime >= scheduleTable[route][i].startTime and
            currentTime < scheduleTable[route][i].endTime
        then
            scheduleStep = i

            break
        end
    end

    local timeLeft = math.floor((scheduleTable[route][scheduleStep].endTime - currentTime) * 60 / 25)

    player:startEvent(eventId, timeLeft, scheduleTable[route][scheduleStep].action, 0, scheduleTable[route][scheduleStep].target)
end

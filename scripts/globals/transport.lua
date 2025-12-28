-----------------------------------
-- Transport
-----------------------------------
xi = xi or {}
xi.transport = xi.transport or {}

-----------------------------------
-- Enums
-----------------------------------
xi.transport.message =
{
    NEARING = 0,
    DOCKING = 1,
}

xi.transport.epochOffset =
{
    NEARING = 265,
    DOCKING = 290,
}

xi.transport.messageTime =
{
    SILVER_SEA = 480,
}

xi.transport.trigger =
{
    mhaura =
    {
        FERRY_ARRIVING_FROM_ALZAHBI = 0,
        FERRY_DEPARTING_TO_ALZAHBI  = 1,
        FERRY_ARRIVING_FROM_SELBINA = 2,
        FERRY_DEPARTING_TO_SELBINA  = 3,
    },
    selbina =
    {
        FERRY_ARRIVING_FROM_MHAURA = 0,
        FERRY_DEPARTING_TO_MHAURA  = 1,
    },
}

xi.transport.interval =
{
    mhaura =
    {
        FROM_TO_ALZAHBI = 480,
        FROM_TO_SELBINA = 480,
    },
    selbina =
    {
        FROM_TO_MHAURA = 480,
    },
}

xi.transport.offset =
{
    mhaura =
    {
        FERRY_ARRIVING_FROM_ALZAHBI = 159,
        FERRY_DEPARTING_TO_ALZAHBI  = 239,
        FERRY_ARRIVING_FROM_SELBINA = 399,
        FERRY_DEPARTING_TO_SELBINA  = 479,
    },
    selbina =
    {
        FERRY_ARRIVING_FROM_MHAURA = 399,
        FERRY_DEPARTING_TO_MHAURA  = 479,
    },
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
    ['Humilitie'      ] = { 231, xi.transport.routes.SELBINA_MHAURA          }, -- Selbina to Mhaura
    ['Kuhn_Tsahnpri'  ] = { 236, xi.transport.routes.SILVER_SEA              }, -- Aht Urhgan Whitegate to Nashmau
    ['Laughing_Bison' ] = { 333, xi.transport.routes.SELBINA_MHAURA_OPEN_SEA }, -- Mhaura to Aht Urhgan Whitegate or Selbina
    ['Yohj_Dukonlhy'  ] = { 231, xi.transport.routes.SILVER_SEA              }, -- Nashmau to Aht Urhgan Whitegate
}

-- times are minutes past midnight, and aligns with the transports.sql entries.
-- Since the cycle is every 480 minutes, 3 cycles are listed for simpler logic
-- time for arrivalStart: time_offset
-- time for arrivalEnd:   time_offset + time_anim_arrive
-- time for departStart:  time_offset + time_anim_arrive + time_waiting
-- time for departEnd:    time_offset + time_anim_arrive + time_waiting + time_anim_depart
-- time for ride on the boat to end: time_offset + time_anim_arrive - 10
local scheduleTable =
{
    -- used by ship and selbina dock timekeepers
    [xi.transport.routes.SELBINA_MHAURA] = -- Ship bound for [Mhaura/Selbina]
    {
        { endTime = utils.timeStringToMinutes('06:40'), action = direction.ARRIVE, target = 0 }, -- (from dock) arrives at SELBINA
        { endTime = utils.timeStringToMinutes('08:00'), action = direction.DEPART, target = 0 }, -- (from dock) headed to MHAURA
        { endTime = utils.timeStringToMinutes('14:40'), action = direction.ARRIVE, target = 0 }, -- (from dock) arrives at SELBINA
        { endTime = utils.timeStringToMinutes('16:00'), action = direction.DEPART, target = 0 }, -- (from dock) headed to MHAURA
        { endTime = utils.timeStringToMinutes('22:40'), action = direction.ARRIVE, target = 0 }, -- (from dock) arrives at SELBINA
        { endTime = utils.timeStringToMinutes('24:00'), action = direction.DEPART, target = 0 }, -- (from dock) headed to MHAURA
    },

    -- used by ship and southern whitegate dock timekeepers
    [xi.transport.routes.OPEN_SEA] = -- Open sea route to [Al Zahbi/Mhaura]
    {
        { endTime = utils.timeStringToMinutes('02:40'), action = direction.ARRIVE, target = 0 }, -- (from dock) arrives at AL_ZAHBI
        { endTime = utils.timeStringToMinutes('04:00'), action = direction.DEPART, target = 0 }, -- (from dock) headed to MHAURA
        { endTime = utils.timeStringToMinutes('10:40'), action = direction.ARRIVE, target = 0 }, -- (from dock) arrives at AL_ZAHBI
        { endTime = utils.timeStringToMinutes('12:00'), action = direction.DEPART, target = 0 }, -- (from dock) headed to MHAURA
        { endTime = utils.timeStringToMinutes('18:40'), action = direction.ARRIVE, target = 0 }, -- (from dock) arrives at AL_ZAHBI
        { endTime = utils.timeStringToMinutes('20:00'), action = direction.DEPART, target = 0 }, -- (from dock) headed to MHAURA
        { endTime = utils.timeStringToMinutes('24:00'), action = direction.ARRIVE, target = 0 }, -- (from dock) arrives at AL_ZAHBI. Continues up to 2:40 AM next day (first entry in this table)
    },

    -- used by ship and nashmau/whitegate dock timekeepers
    [xi.transport.routes.SILVER_SEA] = -- Silver Sea route to [Al Zahbi/Nashmau]
    {
        { endTime = utils.timeStringToMinutes('05:00'), action = direction.ARRIVE, target = 0 },
        { endTime = utils.timeStringToMinutes('08:00'), action = direction.DEPART, target = 0 },
        { endTime = utils.timeStringToMinutes('13:00'), action = direction.ARRIVE, target = 0 },
        { endTime = utils.timeStringToMinutes('16:00'), action = direction.DEPART, target = 0 },
        { endTime = utils.timeStringToMinutes('21:00'), action = direction.ARRIVE, target = 0 },
        { endTime = utils.timeStringToMinutes('24:00'), action = direction.DEPART, target = 0 },
    },

    -- used by Dieh Yamilsiah and Laughin Bison (Mhaura dock only)
    [xi.transport.routes.SELBINA_MHAURA_OPEN_SEA] = -- Combination of Ship bound for [Mhaura/Selbina] and Open sea route to [Al Zahbi/Mhaura]
    {
        { endTime = utils.timeStringToMinutes('02:40'), action = direction.ARRIVE, target = destination.AL_ZAHBI },
        { endTime = utils.timeStringToMinutes('04:00'), action = direction.DEPART, target = destination.AL_ZAHBI },
        { endTime = utils.timeStringToMinutes('06:40'), action = direction.ARRIVE, target = destination.SELBINA  },
        { endTime = utils.timeStringToMinutes('08:00'), action = direction.DEPART, target = destination.SELBINA  },
        { endTime = utils.timeStringToMinutes('10:40'), action = direction.ARRIVE, target = destination.AL_ZAHBI },
        { endTime = utils.timeStringToMinutes('12:00'), action = direction.DEPART, target = destination.AL_ZAHBI },
        { endTime = utils.timeStringToMinutes('14:40'), action = direction.ARRIVE, target = destination.SELBINA  },
        { endTime = utils.timeStringToMinutes('16:00'), action = direction.DEPART, target = destination.SELBINA  },
        { endTime = utils.timeStringToMinutes('18:40'), action = direction.ARRIVE, target = destination.AL_ZAHBI },
        { endTime = utils.timeStringToMinutes('20:00'), action = direction.DEPART, target = destination.AL_ZAHBI },
        { endTime = utils.timeStringToMinutes('22:40'), action = direction.ARRIVE, target = destination.SELBINA  },
        { endTime = utils.timeStringToMinutes('24:00'), action = direction.DEPART, target = destination.SELBINA  },
    },
}

-----------------------------------
-- Public functions
-----------------------------------

xi.transport.captainMessage = function(npc, triggerID, messages)
    local playersInZone = npc:getZone():getPlayers()
    for _, player in pairs(playersInZone) do
        player:showText(player, messages[triggerID])
    end
end

xi.transport.dockMessage = function(npc, triggerID, messages, dock)
    local dockNpcPos =
    {
        [xi.zone.MHAURA] =
        {
            ARRIVING  = { { x = 7.06, y = -1.36, z = 2.20, rotation = 211 }, },
            DEPARTING = { { x = 8.26, y = -1.36, z = 2.20, rotation = 193 }, },
        },
        [xi.zone.SELBINA] =
        {
            ARRIVING  = { { x = 16.768, y = -1.38,  z = -58.843, rotation = 209 }, },
            DEPARTING = { { x = 17.979, y = -1.389, z = -58.800, rotation = 191 }, },
        },
    }

    npc:showText(npc, messages[triggerID])
    if (triggerID % 2) == 0 then
        npc:pathThrough(dockNpcPos[dock].ARRIVING, bit.bor(xi.path.flag.PATROL, xi.path.flag.WALLHACK))
    else
        npc:pathThrough(dockNpcPos[dock].DEPARTING, bit.bor(xi.path.flag.PATROL, xi.path.flag.WALLHACK))
    end
end

-----------------------------------
-- NPC functions
-----------------------------------
xi.transport.onBoatTimekeeperTrigger = function(player, route, travelMessage, arrivingMessage)
    local currentTime = VanadielHour() * 60 + VanadielMinute()
    local timeDiff    = 0

    for i = 1, #scheduleTable[route] do
        if currentTime < scheduleTable[route][i].endTime then
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
    local npcName  = npc:getName()
    local eventId  = dockTable[npcName][1]
    local schedule = scheduleTable[dockTable[npcName][2]]

    -- Fetch Schedule
    local currentTime  = VanadielHour() * 60 + VanadielMinute()
    local scheduleStep = 0

    for i = 1, #schedule do
        if currentTime < schedule[i].endTime then
            scheduleStep = i

            break
        end
    end

    local timeLeft = math.floor((schedule[scheduleStep].endTime - currentTime) * 60 / 25)

    player:startEvent(eventId, timeLeft, schedule[scheduleStep].action, 0, schedule[scheduleStep].target)
end

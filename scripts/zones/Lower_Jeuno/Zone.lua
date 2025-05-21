-----------------------------------
-- Zone: Lower_Jeuno (245)
-----------------------------------
local ID = zones[xi.zone.LOWER_JEUNO]
local lowerJeunoGlobal = require('scripts/zones/Lower_Jeuno/globals')
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCuboidTriggerArea(1, 23, 0, -43, 44, 7, -39) -- Inside Tenshodo HQ. TODO: Find out if this is used other than in ZM 17 (not anymore). Remove if not.
    xi.chocobo.initZone(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    local month = tonumber(os.date('%m'))
    local day = tonumber(os.date('%d'))

    -- Retail start/end dates vary, I am going with Dec 5th through Jan 5th.
    if
        (month == 12 and day >= 5) or
        (month == 1 and day <= 5)
    then
        player:changeMusic(0, 239)
        player:changeMusic(1, 239)
        -- No need for an 'else' to change it back outside these dates as a re-zone will handle that.
    end

    -- MOG HOUSE EXIT
    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(41.2, -5, 84, 85)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onGameHour = function(zone)
    local vanadielHour = VanadielHour()
    local playerOnQuestId = GetServerVariable('[JEUNO]CommService')

    -- Community Service Quest
    -- 7AM: it's daytime. turn off all the lights
    if vanadielHour == 7 then
        for i = 0, 11 do
            local lamp = GetNPCByID(ID.npc.STREETLAMP_OFFSET + i)

            if lamp then
                lamp:setAnimation(xi.anim.CLOSE_DOOR)
            end
        end

    -- 8PM: make quest available
    -- notify anyone in zone with membership card that zauko is recruiting
    elseif vanadielHour == 18 then
        SetServerVariable('[JEUNO]CommService', 0)
        local players = zone:getPlayers()
        for name, player in pairs(players) do
            if player:hasKeyItem(xi.ki.LAMP_LIGHTERS_MEMBERSHIP_CARD) then
                player:messageSpecial(ID.text.ZAUKO_IS_RECRUITING)
            end
        end

    -- 9PM: notify the person on the quest that they can begin lighting lamps
    elseif vanadielHour == 21 then
        local playerOnQuest = GetPlayerByID(GetServerVariable('[JEUNO]CommService'))
        if playerOnQuest then
            playerOnQuest:startEvent(114)
        end

    -- 1AM: if nobody has accepted the quest yet, NPC Vhana Ehgaklywha takes up the task
    -- she starts near Zauko and paths all the way to the Rolanberry exit.
    -- xi.path.flag.WALLHACK because she gets stuck on some terrain otherwise.
    elseif vanadielHour == 1 then
        if playerOnQuestId == 0 then
            local npc = GetNPCByID(ID.npc.VHANA_EHGAKLYWHA)
            if not npc then
                return
            end

            npc:clearPath()
            npc:setStatus(0)
            npc:initNpcAi()
            npc:setPos(xi.path.first(lowerJeunoGlobal.lampPath))
            npc:pathThrough(lowerJeunoGlobal.lampPath, bit.bor(xi.path.flag.PATROL, xi.path.flag.WALLHACK))
        end
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject

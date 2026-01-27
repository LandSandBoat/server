-----------------------------------
-- Zone: Lower_Jeuno (245)
-----------------------------------
local ID = zones[xi.zone.LOWER_JEUNO]
local lowerJeunoGlobal = require('scripts/zones/Lower_Jeuno/globals')
-----------------------------------
require('scripts/quests/jeuno/Community_Service')
-----------------------------------

---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCuboidTriggerArea(1, 23, 0, -43, 44, 7, -39) -- Inside Tenshodo HQ. TODO: Find out if this is used other than in ZM 17 (not anymore). Remove if not.
    xi.chocobo.initZone(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local month = JstMonth()
    local day   = JstDayOfTheMonth()

    -- Retail start/end dates vary, I am going with Dec 5th through Jan 5th.
    if
        (month == 12 and day >= 5) or
        (month == 1 and day <= 5)
    then
        player:changeMusic(0, 239)
        player:changeMusic(1, 239)
        -- No need for an 'else' to change it back outside these dates as a re-zone will handle that.
    end

    return xi.moghouse.onMoghouseZoneEvent(player, prevZone)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onGameHour = function(zone)
    local vanadielHour = VanadielHour()

    -- 01:00 - If nobody has accepted the quest yet, NPC Vhana Ehgaklywha takes up the task
    -- she starts near Zauko and paths all the way to the Rolanberry exit.
    -- xi.path.flag.WALLHACK because she gets stuck on some terrain otherwise.
    if vanadielHour == 1 then
        if xi.quest.communityServiceStartVhana(zone) then
            local vhana = GetNPCByID(ID.npc.VHANA_EHGAKLYWHA)
            if not vhana then
                return
            end

            vhana:clearPath()
            vhana:setStatus(0)
            vhana:initNpcAi()
            vhana:setLocalVar('path', 1)
            vhana:setPos(xi.path.first(lowerJeunoGlobal.lampPath[1]))
            vhana:pathThrough(lowerJeunoGlobal.lampPath[1], bit.bor(xi.path.flag.COORDS, xi.path.flag.WALLHACK))
        end

    -- 05:00 - Turn off all the lights.
    elseif vanadielHour == 5 then
        xi.quest.communityServiceCleanup(zone)

    -- 18:00 - Notify anyone in zone with membership card that zauko is recruiting
    elseif vanadielHour == 18 then
        xi.quest.communityServiceNotification(zone)
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject

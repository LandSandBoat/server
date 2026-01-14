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
    local month = JstMonth()
    local day = JstDayOfTheMonth()

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
    local zauko        = GetNPCByID(ID.npc.ZAUKO)

    if not zauko then
        return
    end

    -- Community Service Quest
    -- 0500: Turn off all the lights, and clear vars
    if vanadielHour == 5 then
        zauko:setLocalVar('commServiceStart', 0)
        zauko:setLocalVar('commServiceComp', 0)
        zone:setLocalVar('allLightsLit', 0)

        for i = 1, 4 do
            zone:setLocalVar('commServPlayer' .. i, 0)
        end

        for i = 0, 11 do
            local lamp = GetNPCByID(ID.npc.STREETLAMP_OFFSET + i)

            if lamp then
                lamp:setAnimation(xi.anim.CLOSE_DOOR)
                lamp:setLocalVar('Option', 0)
            end
        end

    -- 1800: Notify anyone in zone with membership card that zauko is recruiting
    elseif vanadielHour == 18 then
        local players = zone:getPlayers()

        for name, player in pairs(players) do
            if player:hasKeyItem(xi.ki.LAMP_LIGHTERS_MEMBERSHIP_CARD) then
                player:messageSpecial(ID.text.ZAUKO_IS_RECRUITING)
            end
        end

    -- 0100: if nobody has accepted the quest yet, NPC Vhana Ehgaklywha takes up the task
    -- she starts near Zauko and paths all the way to the Rolanberry exit.
    -- xi.path.flag.WALLHACK because she gets stuck on some terrain otherwise.
    elseif vanadielHour == 1 then
        if zauko:getLocalVar('commServiceComp') == 0 then
            local npc = GetNPCByID(ID.npc.VHANA_EHGAKLYWHA)
            if not npc then
                return
            end

            npc:clearPath()
            npc:setStatus(0)
            npc:initNpcAi()
            npc:setLocalVar('path', 1)
            npc:setPos(xi.path.first(lowerJeunoGlobal.lampPath[1]))
            npc:pathThrough(lowerJeunoGlobal.lampPath[1], bit.bor(xi.path.flag.COORDS, xi.path.flag.WALLHACK))
        end
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject

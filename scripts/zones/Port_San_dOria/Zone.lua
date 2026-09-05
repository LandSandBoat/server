-----------------------------------
-- Zone: Port_San_dOria (232)
-----------------------------------
require('scripts/quests/flyers_for_regine')
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    quests.ffr.initZone(zone) -- register trigger areas 1 through 5
    zone:registerCuboidTriggerArea(369, 3.9, -5.3, 40.1, 36.1, 0.5, 68.2) -- Jeuno airship boarding area
end

zoneObject.onZoneIn = function(player, prevZone)
    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        if prevZone == xi.zone.SAN_DORIA_JEUNO_AIRSHIP then
            player:setPos(-1.000, 0.000, 44.000, 128)
            return { 702, -1, bit.bor(xi.cutsceneFlag.RESET_CAMERA, xi.cutsceneFlag.NO_PCS) }
        end
    end

    return xi.moghouse.onMoghouseZoneEvent(player, prevZone)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    quests.ffr.onTriggerAreaEnter(player, triggerArea) -- player approaching Flyers for Regine NPCs
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onTransportEvent = function(player, prevZoneId, transportName)
    if not player:hasKeyItem(xi.ki.AIRSHIP_PASS) then
        player:startEvent(701)
        return
    end

    player:startEvent(700, { isHidden = true, flags = xi.cutsceneFlag.NO_IDLE_WAIT })
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 700 then
        player:setPos(0, 0, 0, 0, 223)
    end
end

return zoneObject

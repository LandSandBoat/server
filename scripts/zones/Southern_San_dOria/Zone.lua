-----------------------------------
-- Zone: Southern_San_dOria (230)
-----------------------------------
require('scripts/quests/flyers_for_regine')
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCuboidTriggerArea(1, -292, -10, 90 , -258, 10, 105)
    quests.ffr.initZone(zone) -- register trigger areas 2 through 6
    xi.events.harvestFestival.applyHalloweenNpcCostumes(zone:getID())
    xi.chocobo.initZone(zone)
    xi.chocoboGame.clearRecord(zone)
    xi.conquest.toggleRegionalNPCs(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    -- MOG HOUSE EXIT
    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(161, -2, 161, 94)
    end
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    quests.ffr.onTriggerAreaEnter(player, triggerArea) -- player approaching Flyers for Regine NPCs
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject

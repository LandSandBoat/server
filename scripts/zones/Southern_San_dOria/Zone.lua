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
    xi.events.harvestFestival.initializeZone(zone)
    xi.rentalChocobo.initZone(zone)
    xi.chocoboGame.clearRecord(zone)
    xi.conquest.toggleRegionalNPCs(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    return xi.moghouse.onMoghouseZoneEvent(player, prevZone)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onNonRegionConquestUpdate(zone, updatetype, ranking, isConquestAlliance)
    if updatetype == xi.conquest.constants.TALLY_END then
        xi.conquest.toggleRegionalNPCs(zone)
    end
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    xi.events.harvestFestival.games.onTriggerAreaEnter(player, triggerArea)
    quests.ffr.onTriggerAreaEnter(player, triggerArea) -- player approaching Flyers for Regine NPCs
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
    xi.events.harvestFestival.games.onTriggerAreaLeave(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject

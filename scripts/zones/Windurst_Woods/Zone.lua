-----------------------------------
-- Zone: Windurst_Woods (241)
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
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
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
    xi.events.harvestFestival.games.onTriggerAreaLeave(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject

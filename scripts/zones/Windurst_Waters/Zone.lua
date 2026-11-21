-----------------------------------
-- Zone: Windurst_Waters (238)
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- Used for Windurst Mission 1-3
    zone:registerCuboidTriggerArea(1, 23, -12, -208, 31, -8, -197)

    xi.events.harvestFestival.initializeZone(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    return xi.moghouse.onMoghouseZoneEvent(player, prevZone)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onNonRegionConquestUpdate(zone, updatetype, ranking, isConquestAlliance)
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

-----------------------------------
-- Zone: Upper_Jeuno (244)
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCuboidTriggerArea(1, -112, -1, 80, -97.8, 0, 94)    -- Marble Bridge Eatery, main
    zone:registerCuboidTriggerArea(2, -97.8, -1, 82, -96.9, 0, 86.5) -- Marble Bridge Eatery, nook

    xi.chocobo.initZone(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    return xi.moghouse.onMoghouseZoneEvent(player, prevZone)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject

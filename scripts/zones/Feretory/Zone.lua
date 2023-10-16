-----------------------------------
-- Zone: Feretory
-----------------------------------
require('scripts/globals/monstrosity')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- Unused
end

zoneObject.onZoneIn = function(player, prevZone)
    return xi.monstrosity.feretoryOnZoneIn(player, prevZone)
end

zoneObject.onZoneOut = function(player)
    xi.monstrosity.feretoryOnZoneOut(player)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    -- Unused
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
    xi.monstrosity.feretoryOnEventUpdate(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    xi.monstrosity.feretoryOnEventFinish(player, csid, option, npc)
end

return zoneObject

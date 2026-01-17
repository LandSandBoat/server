-----------------------------------
-- Zone: Everbloom_Hollow
-----------------------------------

local ID = require("scripts/zones/Everbloom_Hollow/IDs")
-----------------------------------

local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onZoneIn = function(player,prevZone,zone,mob)
 	local cs = -1
	if (prevZone == 81 or prevZone == 84)then
 	GetMobByID(17109357):setHP(0)
 	GetMobByID(17121693):setHP(0)
	end
 	return cs
end

zoneObject.afterZoneIn = function(player,zone)
	player:printToPlayer("Warning: You have 1 hour to complete this challenge.")
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player,csid,option)
end

zoneObject.onEventFinish = function(player,csid,option)
end

return zoneObject
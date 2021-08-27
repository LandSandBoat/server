-----------------------------------
--
-- Zone: Throne_Room (165)
--
-----------------------------------
local ID = require("scripts/zones/Throne_Room/IDs")
require("scripts/globals/conquest")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(114.308, -7.639, 0.022, 126)
    end
    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if (csid == 7) then
        -- You will be transported back to the entrance of Castle Zvahl Baileys
        player:setPos(378.222, -12, -20.299, 125, 161)
    end
end

return zone_object

-----------------------------------
--
-- Zone: Riverne-Site_A01
--
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_A01/IDs")
require("scripts/globals/conquest")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getCurrentMission(COP) == xi.mission.id.cop.ANCIENT_VOWS and player:getCharVar("PromathiaStatus") == 1 then
        cs = 100
    end

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(732.55, -32.5, -506.544, 90) -- {R}
    end

    return cs
end

zone_object.afterZoneIn = function(player)
    if (xi.settings.ENABLE_COP_ZONE_CAP == 1) then -- ZONE WIDE LEVEL RESTRICTION
        player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, 40, 0, 0) -- LV40 cap
    end
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 100 then
        player:setCharVar("PromathiaStatus", 2)
    end
end

return zone_object

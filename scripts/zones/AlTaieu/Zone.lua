-----------------------------------
-- Zone: AlTaieu (33)
-----------------------------------
local ID = require('scripts/zones/AlTaieu/IDs')
require('scripts/globals/keyitems')
require('scripts/globals/missions')
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-25, -1 , -620 , 33)
    end

    if player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.DAWN and player:getCharVar("PromathiaStatus") == 0 then
        cs=167
    end

    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 167 then
        player:setCharVar("PromathiaStatus", 1)
        player:delKeyItem(xi.ki.MYSTERIOUS_AMULET_PRISHE)
        player:messageSpecial(ID.text.RETURN_AMULET_TO_PRISHE, xi.ki.MYSTERIOUS_AMULET)
    end
end

return zone_object

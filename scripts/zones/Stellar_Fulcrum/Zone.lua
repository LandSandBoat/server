-----------------------------------
--
-- Zone: Stellar_Fulcrum
--
-----------------------------------
local ID = require("scripts/zones/Stellar_Fulcrum/IDs")
require("scripts/globals/conquest")
require("scripts/globals/missions")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)

    zone:registerRegion(1, -522, -2, -49,  -517, -1, -43) -- To Upper Delkfutt's Tower
    zone:registerRegion(2, 318, -3, 2,  322, 1, 6) -- Exit BCNM to ?

end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    return cs
end

zone_object.onRegionEnter = function(player, region)

    switch (region:GetRegionID()): caseof
    {
        [1] = function (x)
            player:startEvent(8)
        end,
        [2] = function (x)
            player:startEvent(8)
        end,
    }

end

zone_object.onRegionLeave = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)

    if (csid == 8 and option == 1) then
        player:setPos(-370, -178, -40, 243, 158)
    elseif (csid == 0) then
        player:setMissionStatus(xi.mission.log_id.ZILART, 3)
    end

end

return zone_object

-----------------------------------
--
-- Zone: Xarcabard_[S] (137)
--
-----------------------------------
local ID = require("scripts/zones/Xarcabard_[S]/IDs")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-414, -46.5, 20, 253)
    end
    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

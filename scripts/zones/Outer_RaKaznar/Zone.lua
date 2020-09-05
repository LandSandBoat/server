-----------------------------------
--
-- Zone: Outer Ra’Kanzar (274)
--
-----------------------------------
local ID = require("scripts/zones/Outer_RaKaznar/IDs")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-40, -180, -20, 128)
    end
    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

-----------------------------------
--
-- Zone: Jade_Sepulcher (67)
--
-----------------------------------
local ID = require("scripts/zones/Jade_Sepulcher/IDs")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(340.383, -13.625, -157.447, 189)
    end

    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

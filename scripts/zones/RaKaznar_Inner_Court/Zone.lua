-----------------------------------
--
-- Zone: Ra’Kanzar Inner Court (276)
--
-----------------------------------
local ID = require("scripts/zones/RaKaznar_Inner_Court/IDs")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-476, -520.5, 20, 0)
    end

    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

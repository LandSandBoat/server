-----------------------------------
--
-- Zone: Feretory
--
-----------------------------------
local ID = require("scripts/zones/Feretory/IDs")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1

    player:setPos(-358.000, -3.400, -440.00, 63)

    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

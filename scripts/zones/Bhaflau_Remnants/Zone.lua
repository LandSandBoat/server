-----------------------------------
--
-- Zone: Bhaflau_Remnants
--
-----------------------------------
local ID = require("scripts/zones/Bhaflau_Remnants/IDs")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1

    player:addTempItem(5400)

    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

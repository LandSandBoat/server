-----------------------------------
--
-- Zone: Silver_Sea_Remnants
--
-----------------------------------
local ID = require("scripts/zones/Silver_Sea_Remnants/IDs")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1

    player:addTempItem(5401)

    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

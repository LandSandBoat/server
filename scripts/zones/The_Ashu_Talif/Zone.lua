-----------------------------------
--
-- Zone: The_Ashu_Talif
--
-----------------------------------
local ID = require("scripts/zones/The_Ashu_Talif/IDs")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1

    player:addTempItem(5349)

    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option, target)
end

function onEventFinish(player, csid, option)
    if csid == 101 or csid == 102 then
        player:setPos(0, 0, 0, 0, 54)
    end
end

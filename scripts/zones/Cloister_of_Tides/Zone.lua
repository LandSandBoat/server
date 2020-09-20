-----------------------------------
--
-- Zone: Cloister_of_Tides (211)
--
-----------------------------------
local ID = require("scripts/zones/Cloister_of_Tides/IDs")
require("scripts/globals/conquest")
-----------------------------------

function onInitialize(zone)
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(564.776, 34.297, 500.819, 250)
    end
    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

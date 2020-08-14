-----------------------------------
--
-- Zone: Altar_Room (152)
--
-----------------------------------
local ID = require("scripts/zones/Altar_Room/IDs")
require("scripts/globals/conquest")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getCharVar("FickblixCS") == 1 then
        cs = 10000
    end
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-247.998, 12.609, -100.008, 128)
    end
    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 10000 then
        player:setCharVar("FickblixCS", 0)
    end
end

-----------------------------------
--
-- Zone: Rabao (247)
--
-----------------------------------
local ID = require("scripts/zones/Rabao/IDs")
require("scripts/globals/conquest")
require("scripts/globals/chocobo")
-----------------------------------

function onInitialize(zone)
    tpz.chocobo.initZone(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-20.052, 6.074, -122.408, 193)
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
end

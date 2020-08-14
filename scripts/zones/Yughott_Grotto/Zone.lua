-----------------------------------
--
-- Zone: Yughott_Grotto (142)
--
-----------------------------------
local ID = require("scripts/zones/Yughott_Grotto/IDs")
require("scripts/globals/conquest")
require("scripts/globals/treasure")
require("scripts/globals/helm")
-----------------------------------

function onInitialize(zone)
    tpz.treasure.initZone(zone)
    tpz.helm.initZone(zone, tpz.helm.type.MINING)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(439.814, -42.481, 169.755, 118)
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

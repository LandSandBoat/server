-----------------------------------
--
-- Zone: Abdhaljs_Isle-Purgonorgo
--
-----------------------------------
local ID = require("scripts/zones/Abdhaljs_Isle-Purgonorgo/IDs")
require("scripts/globals/keyitems")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    player:addKeyItem(tpz.ki.MAP_OF_ABDH_ISLE_PURGONORGO)

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(521.600, -3.000, 563.000, 64)
    end
    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

-----------------------------------
--
-- Zone: Halvung (62)
--
-----------------------------------
local ID = require("scripts/zones/Halvung/IDs")
require("scripts/globals/helm")
-----------------------------------

function onInitialize(zone)
    tpz.helm.initZone(zone, tpz.helm.type.MINING)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(160.54, -22.001, 139.988, 244)
    end
    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

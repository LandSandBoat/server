-----------------------------------
--
-- Zone: Ship bound for Selbina Pirates (227)
--
-----------------------------------
local ID = require("scripts/zones/Ship_bound_for_Selbina_Pirates/IDs")
require("scripts/globals/zone")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        local position = math.random(-2, 2) + 0.150
        player:setPos(position, -2.100, 3.250, 64)
    end

    return cs

end

function onTransportEvent(player, transport)
    player:startEvent(255)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 255 then
        player:setPos(0, 0, 0, 0, tpz.zone.SELBINA)
    end
end

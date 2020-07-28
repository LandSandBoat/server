-----------------------------------
--
-- Zone: Ship_bound_for_Selbina (220)
--
-----------------------------------
local ID = require("scripts/zones/Ship_bound_for_Selbina/IDs")
require("scripts/globals/keyitems")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)

    local cs = -1

    if ((player:getXPos() == 0) and (player:getYPos() == 0) and (player:getZPos() == 0)) then
        local position = math.random(-2, 2) + 0.150
        player:setPos(position, -2.100, 3.250, 64)
    end

    if (player:hasKeyItem(tpz.ki.SEANCE_STAFF) and player:getCharVar("Enagakure_Killed") == 0 and not GetMobByID(ID.mob.ENAGAKURE):isSpawned()) then
        SpawnMob(ID.mob.ENAGAKURE)
    end

    return cs

end

function onTransportEvent(player, transport)
    player:startEvent(255)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 255) then
        player:setPos(0, 0, 0, 0, 248)
    end
end

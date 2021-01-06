-----------------------------------
--
-- Zone: Sea_Serpent_Grotto (176)
--
-----------------------------------
local ID = require("scripts/zones/Sea_Serpent_Grotto/IDs")
require("scripts/globals/conquest")
require("scripts/globals/treasure")
require("scripts/globals/zone")
require("scripts/globals/keyitems")
-----------------------------------

function onInitialize(zone)
    -- Charybdis PH alternates, remove one
    local keys = {}
    for k, v in pairs(ID.mob.CHARYBDIS_PH) do table.insert(keys, k) end
    DespawnMob(keys[math.random(#keys)])

    tpz.treasure.initZone(zone)
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-60.566, -2.127, 412, 54)
    end
    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

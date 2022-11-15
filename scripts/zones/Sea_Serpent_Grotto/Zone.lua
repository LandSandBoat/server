-----------------------------------
-- Zone: Sea_Serpent_Grotto (176)
-----------------------------------
local ID = require('scripts/zones/Sea_Serpent_Grotto/IDs')
require('scripts/globals/conquest')
require('scripts/globals/treasure')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- Charybdis PH alternates, remove one
    local keys = {}

    for k, v in pairs(ID.mob.CHARYBDIS_PH) do
        table.insert(keys, k)
    end

    DespawnMob(keys[math.random(1, #keys)])

    xi.treasure.initZone(zone)
end

zoneObject.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-60.566, -2.127, 412, 54)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
end

return zoneObject

-----------------------------------
-- Zone: Sea_Serpent_Grotto (176)
-----------------------------------
local ID = require('scripts/zones/Sea_Serpent_Grotto/IDs')
require('scripts/globals/conquest')
require('scripts/globals/treasure')
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    -- Only one Charbydis PH is up at one time
    local chooseManta = math.random(1,2)
    local mantaOne = ID.mob.CHARYBDIS - 2
    local mantaTwo = ID.mob.CHARYBDIS - 4
    if chooseManta == 2 then
        DisallowRespawn(mantaOne, true)
        DespawnMob(mantaOne)
        SpawnMob(mantaTwo)
    else
        DisallowRespawn(mantaTwo, true)
        DespawnMob(mantaTwo)
        SpawnMob(mantaOne)
    end

    xi.treasure.initZone(zone)
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-60.566, -2.127, 412, 54)
    end

    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

return zone_object

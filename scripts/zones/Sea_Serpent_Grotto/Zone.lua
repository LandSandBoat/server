-----------------------------------
-- Zone: Sea_Serpent_Grotto (176)
-----------------------------------
local ID = require('scripts/zones/Sea_Serpent_Grotto/IDs')
require('scripts/globals/conquest')
require('scripts/globals/treasure')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- Only one Charbydis PH is up at one time
    local chooseManta = math.random(1, 2)
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

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
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

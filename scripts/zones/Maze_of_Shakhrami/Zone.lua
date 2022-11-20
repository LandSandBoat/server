-----------------------------------
-- Zone: Maze of Shakhrami (198)
-----------------------------------
local ID = require('scripts/zones/Maze_of_Shakhrami/IDs')
require('scripts/globals/conquest')
require('scripts/globals/treasure')
require('scripts/globals/helm')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    if math.random(1, 2) == 1 then
        DisallowRespawn(ID.mob.LEECH_KING, true)
        DisallowRespawn(ID.mob.ARGUS, false)
        UpdateNMSpawnPoint(ID.mob.ARGUS)
        GetMobByID(ID.mob.ARGUS):setRespawnTime(math.random(900, 7200))
    else
        DisallowRespawn(ID.mob.ARGUS, true)
        DisallowRespawn(ID.mob.LEECH_KING, false)
        UpdateNMSpawnPoint(ID.mob.LEECH_KING)
        GetMobByID(ID.mob.LEECH_KING):setRespawnTime(math.random(900, 7200))
    end

    xi.treasure.initZone(zone)
    xi.helm.initZone(zone, xi.helm.type.EXCAVATION)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-345, -11, -180, 239)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
end

return zoneObject

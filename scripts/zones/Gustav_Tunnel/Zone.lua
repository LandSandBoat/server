-----------------------------------
-- Zone: Gustav Tunnel (212)
-----------------------------------
local ID = require('scripts/zones/Gustav_Tunnel/IDs')
require('scripts/globals/conquest')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.BUNE)
    GetMobByID(ID.mob.BUNE):setRespawnTime(math.random(900, 10800))
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
        player:setPos(-260.013, -21.802, -276.352, 205)
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

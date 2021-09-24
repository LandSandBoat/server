-----------------------------------
--
-- Zone: East_Ronfaure_[S] (81)
--
-----------------------------------
local ID = require("scripts/zones/East_Ronfaure_[S]/IDs")
require("scripts/globals/missions")
require("scripts/globals/helm")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.MYRADROSH)
    GetMobByID(ID.mob.MYRADROSH):setRespawnTime(math.random(5400, 7200))

    xi.helm.initZone(zone, xi.helm.type.LOGGING)
    xi.voidwalker.zoneOnInit(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(86.131, -65.817, 273.861, 25)
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

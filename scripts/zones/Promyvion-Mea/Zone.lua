-----------------------------------
-- Zone: Promyvion-Mea (20)
-----------------------------------
local ID = require('scripts/zones/Promyvion-Mea/IDs')
require('scripts/globals/promyvion')
require('scripts/globals/settings')
require('scripts/globals/status')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
--    UpdateNMSpawnPoint(ID.mob.COVETAR)
--    GetMobByID(ID.mob.COVETAR):setRespawnTime(math.random(3600, 21600))
    xi.promyvion.initZone(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-93.268, 0, 170.749, 162) -- Floor 1 (R)
    end

    return cs
end

zoneObject.afterZoneIn = function(player)
    if xi.settings.main.ENABLE_COP_ZONE_CAP == 1 then
        player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, 30, 0, 0)
    end
end

zoneObject.onRegionEnter = function(player, region)
    xi.promyvion.onRegionEnter(player, region)
end

zoneObject.onRegionLeave = function(player, region)
end

zoneObject.onEventUpdate = function(player, region)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 46 and option == 1 then
        player:setPos(279.988, -86.459, -25.994, 63, 14) -- To Hall of Transferance (R)
    end
end

return zoneObject

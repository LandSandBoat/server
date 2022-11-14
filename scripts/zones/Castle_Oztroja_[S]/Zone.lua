-----------------------------------
-- Zone: Castle_Oztroja_[S] (99)
-----------------------------------
local ID = require('scripts/zones/Castle_Oztroja_[S]/IDs')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.DUU_MASA_THE_ONECUT)
    GetMobByID(ID.mob.DUU_MASA_THE_ONECUT):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.DEE_ZELKO_THE_ESOTERIC)
    GetMobByID(ID.mob.DEE_ZELKO_THE_ESOTERIC):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.MARQUIS_FORNEUS)
    GetMobByID(ID.mob.MARQUIS_FORNEUS):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.LOO_KUTTO_THE_PENSIVE)
    GetMobByID(ID.mob.LOO_KUTTO_THE_PENSIVE):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.FLESHGNASHER)
    GetMobByID(ID.mob.FLESHGNASHER):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.VEE_LADU_THE_TITTERER)
    GetMobByID(ID.mob.VEE_LADU_THE_TITTERER):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.MAA_ILLMU_THE_BESTOWER)
    GetMobByID(ID.mob.MAA_ILLMU_THE_BESTOWER):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.ASTERION)
    GetMobByID(ID.mob.ASTERION):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.SUU_XICU_THE_CANTABILE)
    GetMobByID(ID.mob.SUU_XICU_THE_CANTABILE):setRespawnTime(math.random(900, 10800))
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-239.447, -1.813, -19.98, 250)
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

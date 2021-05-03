-----------------------------------
--
-- Zone: Castle_Oztroja_[S] (99)
--
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja_[S]/IDs")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.DUU_MASA_THE_ONECUT)
    if RESPAWN_SAVE_TIME then
        GetMobByID(ID.mob.DUU_MASA_THE_ONECUT):setRespawnTime(math.random(RESPAWN_SAVE_TIME_MIN, RESPAWN_SAVE_TIME_MAX))
    else
        GetMobByID(ID.mob.DUU_MASA_THE_ONECUT):setRespawnTime(math.random(900, 10800))
    end

    UpdateNMSpawnPoint(ID.mob.DEE_ZELKO_THE_ESOTERIC)
    if RESPAWN_SAVE_TIME then
        GetMobByID(ID.mob.DEE_ZELKO_THE_ESOTERIC):setRespawnTime(math.random(RESPAWN_SAVE_TIME_MIN, RESPAWN_SAVE_TIME_MAX))
    else
        GetMobByID(ID.mob.DEE_ZELKO_THE_ESOTERIC):setRespawnTime(math.random(900, 10800))
    end

    UpdateNMSpawnPoint(ID.mob.MARQUIS_FORNEUS)
    if RESPAWN_SAVE_TIME then
        GetMobByID(ID.mob.MARQUIS_FORNEUS):setRespawnTime(math.random(RESPAWN_SAVE_TIME_MIN, RESPAWN_SAVE_TIME_MAX))
    else
        GetMobByID(ID.mob.MARQUIS_FORNEUS):setRespawnTime(math.random(900, 10800))
    end

    UpdateNMSpawnPoint(ID.mob.LOO_KUTTO_THE_PENSIVE)
    if RESPAWN_SAVE_TIME then
        GetMobByID(ID.mob.LOO_KUTTO_THE_PENSIVE):setRespawnTime(math.random(RESPAWN_SAVE_TIME_MIN, RESPAWN_SAVE_TIME_MAX))
    else
        GetMobByID(ID.mob.LOO_KUTTO_THE_PENSIVE):setRespawnTime(math.random(900, 10800))
    end

    UpdateNMSpawnPoint(ID.mob.FLESHGNASHER)
    if RESPAWN_SAVE_TIME then
        GetMobByID(ID.mob.FLESHGNASHER):setRespawnTime(math.random(RESPAWN_SAVE_TIME_MIN, RESPAWN_SAVE_TIME_MAX))
    else
        GetMobByID(ID.mob.FLESHGNASHER):setRespawnTime(math.random(900, 10800))
    end

    UpdateNMSpawnPoint(ID.mob.VEE_LADU_THE_TITTERER)
    if RESPAWN_SAVE_TIME then
        GetMobByID(ID.mob.VEE_LADU_THE_TITTERER):setRespawnTime(math.random(RESPAWN_SAVE_TIME_MIN, RESPAWN_SAVE_TIME_MAX))
    else
        GetMobByID(ID.mob.VEE_LADU_THE_TITTERER):setRespawnTime(math.random(900, 10800))
    end

    UpdateNMSpawnPoint(ID.mob.MAA_ILLMU_THE_BESTOWER)
    if RESPAWN_SAVE_TIME then
        GetMobByID(ID.mob.MAA_ILLMU_THE_BESTOWER):setRespawnTime(math.random(RESPAWN_SAVE_TIME_MIN, RESPAWN_SAVE_TIME_MAX))
    else
        GetMobByID(ID.mob.MAA_ILLMU_THE_BESTOWER):setRespawnTime(math.random(900, 10800))
    end

    UpdateNMSpawnPoint(ID.mob.ASTERION)
    if RESPAWN_SAVE_TIME then
        GetMobByID(ID.mob.ASTERION):setRespawnTime(math.random(RESPAWN_SAVE_TIME_MIN, RESPAWN_SAVE_TIME_MAX))
    else
        GetMobByID(ID.mob.ASTERION):setRespawnTime(math.random(900, 10800))
    end

    UpdateNMSpawnPoint(ID.mob.SUU_XICU_THE_CANTABILE)
    if RESPAWN_SAVE_TIME then
        GetMobByID(ID.mob.SUU_XICU_THE_CANTABILE):setRespawnTime(math.random(RESPAWN_SAVE_TIME_MIN, RESPAWN_SAVE_TIME_MAX))
    else
        GetMobByID(ID.mob.SUU_XICU_THE_CANTABILE):setRespawnTime(math.random(900, 10800))
    end
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-239.447, -1.813, -19.98, 250)
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

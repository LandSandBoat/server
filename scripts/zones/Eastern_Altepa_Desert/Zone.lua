-----------------------------------
--
-- Zone: Eastern_Altepa_Desert (114)
--
-----------------------------------
local ID = require("scripts/zones/Eastern_Altepa_Desert/IDs")
require("scripts/quests/i_can_hear_a_rainbow")
require("scripts/globals/chocobo_digging")
require("scripts/globals/conquest")
require("scripts/globals/chocobo")
-----------------------------------
local zone_object = {}

zone_object.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

zone_object.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.NANDI)
    if RESPAWN_SAVE_TIME then
        GetMobByID(ID.mob.NANDI):setRespawnTime(math.random(RESPAWN_SAVE_TIME_MIN, RESPAWN_SAVE_TIME_MAX))
    else
        GetMobByID(ID.mob.NANDI):setRespawnTime(math.random(3600, 4200))
    end

    UpdateNMSpawnPoint(ID.mob.CACTROT_RAPIDO)
    if RESPAWN_SAVE_TIME then
        GetMobByID(ID.mob.CACTROT_RAPIDO):setRespawnTime(math.random(RESPAWN_SAVE_TIME_MIN, RESPAWN_SAVE_TIME_MAX))
    else
        GetMobByID(ID.mob.CACTROT_RAPIDO):setRespawnTime(math.random(900, 10800))
    end

    UpdateNMSpawnPoint(ID.mob.CENTURIO_XII_I)
    if RESPAWN_SAVE_TIME then
        GetMobByID(ID.mob.CENTURIO_XII_I):setRespawnTime(math.random(RESPAWN_SAVE_TIME_MIN, RESPAWN_SAVE_TIME_MAX))
    else
        GetMobByID(ID.mob.CENTURIO_XII_I):setRespawnTime(math.random(900, 10800))
    end

    xi.conq.setRegionalConquestOverseers(zone:getRegionID())
    xi.chocobo.initZone(zone)
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos( 260.09, 6.013, 320.454, 76)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 2
    end

    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
    if csid == 2 then
        quests.rainbow.onEventUpdate(player)
    end
end

zone_object.onEventFinish = function(player, csid, option)
end

return zone_object

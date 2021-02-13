-----------------------------------
--
-- Zone: Yhoator_Jungle (124)
--
-----------------------------------
local ID = require("scripts/zones/Yhoator_Jungle/IDs")
require("scripts/quests/i_can_hear_a_rainbow")
require("scripts/globals/chocobo_digging")
require("scripts/globals/conquest")
require("scripts/globals/chocobo")
require("scripts/globals/helm")
require("scripts/globals/zone")
require("scripts/globals/beastmentreasure")
-----------------------------------
local zone_object = {}

zone_object.onChocoboDig = function(player, precheck)
    return tpz.chocoboDig.start(player, precheck)
end

zone_object.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.WOODLAND_SAGE)
    GetMobByID(ID.mob.WOODLAND_SAGE):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.POWDERER_PENNY)
    GetMobByID(ID.mob.POWDERER_PENNY):setRespawnTime(math.random(5400, 7200))

    UpdateNMSpawnPoint(ID.mob.BISQUE_HEELED_SUNBERRY)
    GetMobByID(ID.mob.BISQUE_HEELED_SUNBERRY):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.BRIGHT_HANDED_KUNBERRY)
    GetMobByID(ID.mob.BRIGHT_HANDED_KUNBERRY):setRespawnTime(math.random(900, 10800))

    tpz.conq.setRegionalConquestOverseers(zone:getRegionID())

    tpz.helm.initZone(zone, tpz.helm.type.HARVESTING)
    tpz.helm.initZone(zone, tpz.helm.type.LOGGING)
    tpz.chocobo.initZone(zone)

    tpz.bmt.updatePeddlestox(tpz.zone.YUHTUNGA_JUNGLE, ID.npc.PEDDLESTOX)
end

zone_object.onGameDay = function()
    tpz.bmt.updatePeddlestox(tpz.zone.YHOATOR_JUNGLE, ID.npc.PEDDLESTOX)
end

zone_object.onConquestUpdate = function(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onZoneIn = function( player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos( 299.997, -5.838, -622.998, 190)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 2
    end

    return cs
end

zone_object.onRegionEnter = function( player, region)
end

zone_object.onEventUpdate = function( player, csid, option)
    if csid == 2 then
        quests.rainbow.onEventUpdate(player)
    end
end

zone_object.onEventFinish = function( player, csid, option)
end

return zone_object

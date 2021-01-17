-----------------------------------
--
-- Zone: Western_Altepa_Desert (125)
--
-----------------------------------
local ID = require("scripts/zones/Western_Altepa_Desert/IDs")
require("scripts/quests/i_can_hear_a_rainbow")
require("scripts/globals/chocobo_digging")
require("scripts/globals/conquest")
require("scripts/globals/world")
require("scripts/globals/zone")
require("scripts/globals/beastmentreasure")
-----------------------------------
local zone_object = {}

zone_object.onChocoboDig = function(player, precheck)
    return tpz.chocoboDig.start(player, precheck)
end

zone_object.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.KING_VINEGARROON)
    GetMobByID(ID.mob.KING_VINEGARROON):setRespawnTime(math.random(900, 10800))

    tpz.bmt.updatePeddlestox(tpz.zone.YUHTUNGA_JUNGLE, ID.npc.PEDDLESTOX)
end

zone_object.onGameDay = function()
    tpz.bmt.updatePeddlestox(tpz.zone.WESTERN_ALTEPA_DESERT, ID.npc.PEDDLESTOX)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-19.901, 13.607, 440.058, 78)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 2
    end

    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
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

zone_object.onZoneWeatherChange = function(weather)
    local KV = GetMobByID(ID.mob.KING_VINEGARROON)

    if KV:getCurrentAction() == tpz.act.DESPAWN and (weather == tpz.weather.DUST_STORM or weather == tpz.weather.SAND_STORM) then
        KV:spawn()
    elseif KV:getCurrentAction() == tpz.act.ROAMING and weather ~= tpz.weather.DUST_STORM and weather ~= tpz.weather.SAND_STORM then
        DespawnMob(ID.mob.KING_VINEGARROON)
    end
end

return zone_object

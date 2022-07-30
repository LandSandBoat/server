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
require("scripts/missions/amk/helpers")
-----------------------------------
local zone_object = {}

zone_object.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

zone_object.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.KING_VINEGARROON)
    GetMobByID(ID.mob.KING_VINEGARROON):setRespawnTime(math.random(900, 10800))

    xi.bmt.updatePeddlestox(xi.zone.YUHTUNGA_JUNGLE, ID.npc.PEDDLESTOX)
end

zone_object.onGameDay = function()
    xi.bmt.updatePeddlestox(xi.zone.WESTERN_ALTEPA_DESERT, ID.npc.PEDDLESTOX)

    -- Chocobo Digging.
    SetServerVariable("[DIG]ZONE125_ITEMS", 0)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-19.901, 13.607, 440.058, 78)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 2
    end

    -- AMK06/AMK07
    if xi.settings.main.ENABLE_AMK == 1 then
        xi.amk.helpers.tryRandomlyPlaceDiggingLocation(player)
    end

    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
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
    if xi.settings.main.ENABLE_WOTG == 1 then
        local dahu = GetMobByID(ID.mob.DAHU)
        if
            not dahu:isSpawned() and os.time() > dahu:getLocalVar("cooldown") and
            (weather == xi.weather.DUST_STORM or weather == xi.weather.SAND_STORM)
        then
            DisallowRespawn(dahu:getID(), false)
            dahu:setRespawnTime(math.random(30, 150)) -- pop 30-150 sec after wind weather starts
        end
    end

    local kingV = GetMobByID(ID.mob.KING_VINEGARROON)
    local kvre = kingV:getLocalVar("respawn")
    if not kingV:isSpawned() and os.time() > kvre and weather == xi.weather.DUST_STORM then
        -- 10% chance for KV pop at start of single earth weather
        local chance = math.random(1, 10)
        if chance == 1 then
            DisallowRespawn(kingV:getID(), false)
            SpawnMob(ID.mob.KING_VINEGARROON)
        end
    elseif not kingV:isSpawned() and os.time() > kvre and weather == xi.weather.SAND_STORM then
        DisallowRespawn(kingV:getID(), false)
        SpawnMob(ID.mob.KING_VINEGARROON)
    end

end

return zone_object

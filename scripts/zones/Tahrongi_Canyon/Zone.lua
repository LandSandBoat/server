-----------------------------------
--
-- Zone: Tahrongi_Canyon (117)
--
-----------------------------------
local ID = require("scripts/zones/Tahrongi_Canyon/IDs")
require("scripts/quests/i_can_hear_a_rainbow")
require("scripts/globals/chocobo_digging")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/chocobo")
require("scripts/globals/world")
require("scripts/globals/helm")
require("scripts/globals/zone")
require("scripts/missions/amk/helpers")
-----------------------------------
local zone_object = {}

zone_object.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

zone_object.onInitialize = function(zone)
    xi.helm.initZone(zone, xi.helm.type.EXCAVATION)
    xi.chocobo.initZone(zone)
    xi.voidwalker.zoneOnInit(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(442.781, -1.641, -40.144, 160)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 35
    elseif player:getCurrentMission(WINDURST) == xi.mission.id.windurst.VAIN and player:getMissionStatus(player:getNation()) == 1 then
        cs = 37
    end

    -- AMK06/AMK07
    if xi.settings.ENABLE_AMK == 1 then
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
    if csid == 35 then
        quests.rainbow.onEventUpdate(player)
    elseif csid == 37 then
        if player:getPreviousZone() == xi.zone.EAST_SARUTABARUTA or player:getPreviousZone() == xi.zone.BUBURIMU_PENINSULA then
            player:updateEvent(0, 0, 0, 0, 0, 7)
        elseif player:getPreviousZone() == xi.zone.MAZE_OF_SHAKHRAMI then
            player:updateEvent(0, 0, 0, 0, 0, 6)
        end
    end
end

zone_object.onEventFinish = function(player, csid, option)
end

local function isHabrokWeather(weather)
    return (weather == xi.weather.DUST_STORM or weather == xi.weather.SAND_STORM or weather == xi.weather.WIND or weather == xi.weather.GALES)
end

zone_object.onZoneWeatherChange = function(weather)
    local habrok = GetMobByID(ID.mob.HABROK)

    if habrok:isSpawned() and not isHabrokWeather(weather) then
        DespawnMob(ID.mob.HABROK)
    elseif not habrok:isSpawned() and isHabrokWeather(weather) and os.time() > habrok:getLocalVar("pop") then
        SpawnMob(ID.mob.HABROK)
    end
end

return zone_object

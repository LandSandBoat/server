-----------------------------------
--
-- Zone: Tahrongi_Canyon (117)
--
-----------------------------------
local ID = require("scripts/zones/Tahrongi_Canyon/IDs")
require("scripts/globals/icanheararainbow")
require("scripts/globals/chocobo_digging")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/chocobo")
require("scripts/globals/weather")
require("scripts/globals/helm")
require("scripts/globals/zone")
-----------------------------------

function onChocoboDig(player, precheck)
    return tpz.chocoboDig.start(player, precheck)
end

function onInitialize(zone)
    tpz.helm.initZone(zone, tpz.helm.type.EXCAVATION)
    tpz.chocobo.initZone(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(442.781, -1.641, -40.144, 160)
    end

    if triggerLightCutscene(player) then -- Quest: I Can Hear A Rainbow
        cs = 35
    elseif player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.VAIN and player:getCharVar("MissionStatus") == 1 then
        cs = 37
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
    if csid == 35 then
        lightCutsceneUpdate(player) -- Quest: I Can Hear A Rainbow
    elseif csid == 37 then
        if player:getPreviousZone() == tpz.zone.EAST_SARUTABARUTA or player:getPreviousZone() == tpz.zone.BUBURIMU_PENINSULA then
            player:updateEvent(0, 0, 0, 0, 0, 7)
        elseif player:getPreviousZone() == tpz.zone.MAZE_OF_SHAKHRAMI then
            player:updateEvent(0, 0, 0, 0, 0, 6)
        end
    end
end

function onEventFinish(player, csid, option)
    if csid == 35 then
        lightCutsceneFinish(player) -- Quest: I Can Hear A Rainbow
    end
end

local function isHabrokWeather(weather)
    return (weather == tpz.weather.DUST_STORM or weather == tpz.weather.SAND_STORM or weather == tpz.weather.WIND or weather == tpz.weather.GALES)
end

function onZoneWeatherChange(weather)
    local habrok = GetMobByID(ID.mob.HABROK)

    if habrok:isSpawned() and not isHabrokWeather(weather) then
        DespawnMob(ID.mob.HABROK)
    elseif not habrok:isSpawned() and isHabrokWeather(weather) and os.time() > habrok:getLocalVar("pop") then
        SpawnMob(ID.mob.HABROK)
    end
end

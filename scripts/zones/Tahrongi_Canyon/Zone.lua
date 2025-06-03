-----------------------------------
-- Zone: Tahrongi_Canyon (117)
-----------------------------------
local ID = zones[xi.zone.TAHRONGI_CANYON]
require('scripts/quests/i_can_hear_a_rainbow')
require('scripts/missions/amk/helpers')
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.helm.initZone(zone, xi.helmType.EXCAVATION)
    xi.chocobo.initZone(zone)
    xi.voidwalker.zoneOnInit(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(442.781, -1.641, -40.144, 160)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 35
    end

    -- AMK06/AMK07
    if xi.settings.main.ENABLE_AMK == 1 then
        xi.amk.helpers.tryRandomlyPlaceDiggingLocation(player)
    end

    return cs
end

zoneObject.afterZoneIn = function(player)
    xi.chocoboGame.handleMessage(player)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
    if csid == 35 then
        quests.rainbow.onEventUpdate(player)
    end
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

local function isHabrokWeather(weather)
    return weather == xi.weather.DUST_STORM or
        weather == xi.weather.SAND_STORM or
        weather == xi.weather.WIND or
        weather == xi.weather.GALES
end

zoneObject.onZoneWeatherChange = function(weather)
    local habrok = GetMobByID(ID.mob.HABROK)
    if habrok then
        if habrok:isSpawned() and not isHabrokWeather(weather) then
            DespawnMob(ID.mob.HABROK)
        elseif
            not habrok:isSpawned() and
            isHabrokWeather(weather) and
            os.time() > habrok:getLocalVar('pop')
        then
            SpawnMob(ID.mob.HABROK)
        end
    end
end

return zoneObject

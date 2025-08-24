-----------------------------------
-- Zone: Tahrongi_Canyon (117)
-----------------------------------
local ID = zones[xi.zone.TAHRONGI_CANYON]
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
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

local habrokWeatherTable =
set{
    xi.weather.DUST_STORM,
    xi.weather.SAND_STORM,
    xi.weather.WIND,
    xi.weather.GALES
}

zoneObject.onZoneWeatherChange = function(weather)
    local habrok          = GetMobByID(ID.mob.HABROK)
    local isHabrokWeather = habrokWeatherTable[weather]
    if habrok then
        if habrok:isSpawned() and not isHabrokWeather then
            DespawnMob(ID.mob.HABROK)
        elseif
            not habrok:isSpawned() and
            isHabrokWeather and
            GetSystemTime() > habrok:getLocalVar('pop')
        then
            SpawnMob(ID.mob.HABROK)
        end
    end
end

return zoneObject

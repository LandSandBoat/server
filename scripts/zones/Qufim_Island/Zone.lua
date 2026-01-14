-----------------------------------
-- Zone: Qufim_Island (126)
-----------------------------------
local ID = zones[xi.zone.QUFIM_ISLAND]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.conquest.setRegionalConquestOverseers(zone:getRegionID())
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-286.271, -21.619, 320.084, 255)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

zoneObject.onZoneWeatherChange = function(weather)
    -- NM Dosetsu Tree only spawns during thunder weather
    local dosetsuTree = GetMobByID(ID.mob.DOSETSU_TREE)

    if not dosetsuTree then
        return
    end

    if weather == xi.weather.THUNDER or weather == xi.weather.THUNDERSTORMS then
        -- Spawn if respawn is up
        if
            not dosetsuTree:isSpawned() and
            GetSystemTime() > dosetsuTree:getLocalVar('respawn')
        then
            xi.mob.updateNMSpawnPoint(dosetsuTree)
            SpawnMob(ID.mob.DOSETSU_TREE)
        end
    else
        if
            dosetsuTree:isSpawned() and
            not dosetsuTree:isEngaged()
        then
            DespawnMob(ID.mob.DOSETSU_TREE)
        end
    end
end

return zoneObject

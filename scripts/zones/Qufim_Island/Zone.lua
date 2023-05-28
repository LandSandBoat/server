-----------------------------------
-- Zone: Qufim_Island (126)
-----------------------------------
local ID = require('scripts/zones/Qufim_Island/IDs')
require('scripts/globals/conquest')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.conq.setRegionalConquestOverseers(zone:getRegionID())
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
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

zoneObject.onZoneOut = function(player)
    if player:hasStatusEffect(xi.effect.BATTLEFIELD) then
        player:delStatusEffect(xi.effect.BATTLEFIELD)
    end
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
end

zoneObject.onZoneWeatherChange = function(weather)
    local dosetsu = GetMobByID(ID.mob.DOSETSU_TREE)
    if
        not dosetsu:isSpawned() and
        os.time() > dosetsu:getLocalVar("respawn") and
        (weather == xi.weather.THUNDER or weather == xi.weather.THUNDERSTORMS)
    then
        DisallowRespawn(dosetsu:getID(), false)
        dosetsu:setRespawnTime(math.random(30, 150)) -- pop 30-150 sec after thunder weather starts
    end
end

return zoneObject

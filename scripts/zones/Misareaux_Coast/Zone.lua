-----------------------------------
-- Zone: Misareaux_Coast (25)
-----------------------------------
local misareauxGlobal = require('scripts/zones/Misareaux_Coast/globals')
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.helm.initZone(zone, xi.helmType.LOGGING)
    misareauxGlobal.ziphiusHandleQM()
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
        player:setPos(634, 22, -222, 111)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onGameHour = function(zone)
    local vHour = VanadielHour()

    if vHour >= 22 or vHour <= 7 then
        misareauxGlobal.ziphiusHandleQM()
    end
end

zoneObject.onZoneWeatherChange = function(weather)
    local ID = zones[xi.zone.MISAREAUX_COAST]
    local odqan1 = GetMobByID(ID.mob.ODQAN[1])
    local odqan2 = GetMobByID(ID.mob.ODQAN[2])

    if weather == xi.weather.FOG and odqan1 and odqan2 then
        -- Check which Odqan is allowed to spawn
        if odqan1:getLocalVar('canSpawn') == 1 then
            DisallowRespawn(odqan1:getID(), false)
            DisallowRespawn(odqan2:getID(), true)
        elseif odqan2:getLocalVar('canSpawn') == 1 then
            DisallowRespawn(odqan2:getID(), false)
            DisallowRespawn(odqan1:getID(), true)
        end
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject

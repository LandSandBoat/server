-----------------------------------
-- Zone: Misareaux_Coast (25)
-----------------------------------
require("scripts/globals/conquest")
require("scripts/globals/helm")
local ID = require("scripts/zones/Misareaux_Coast/IDs")
local misareauxGlobal = require("scripts/zones/Misareaux_Coast/globals")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    xi.helm.initZone(zone, xi.helm.type.LOGGING)
    misareauxGlobal.ziphiusHandleQM()
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(567.624, -20, 280.775, 120)
    end
    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onGameHour = function(zone)
    local vHour = VanadielHour()
    if vHour >= 22 or vHour <= 7 then
        misareauxGlobal.ziphiusHandleQM()
    end
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

zone_object.onZoneWeatherChange = function(weather)
    if os.time() > GetMobByID(ID.mob.ODQAN):getLocalVar("odqanRespawn") and weather == xi.weather.FOG then
        local chooseOdqan = GetMobByID(ID.mob.ODQAN):setLocalVar("chooseOdqan")
        local count = 1

        for ph, nm in pairs(ID.mob.ODQAN_PH) do
            if count == chooseOdqan then
                DisallowRespawn(ph, true)
                DisallowRespawn(nm, false)
                DespawnMob(ph) -- Ensure PH is not up
                SpawnMob(nm) -- Spawn Odqan
            else
                count = count + 1
            end
        end
    end
end

return zone_object

-----------------------------------
-- Zone: Escha - Zi'Tah (288)
-----------------------------------
local ID = require('scripts/zones/Escha_ZiTah/IDs')
require('scripts/globals/missions')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-345.173, 1.232, -179.980, 178)
    end

    if player:getCurrentMission(ROV) == xi.mission.id.rov.EDDIES_OF_DESPAIR_I then
        cs = 1
    end

    xi.escha.cleanUpKeyItems(player)

    local vorsealA = player:getCharVar("vorseal_a") -- TODO: Convert to sql.
    local vorsealB = player:getCharVar("vorseal_b") -- TODO: Convert to sql.
    local vorsealC = player:getCharVar("vorseal_c") -- TODO: Convert to sql.

    if  vorsealA > 0 or vorsealB > 0 or vorsealC > 0 and prevZone ~= 288 then
        player:addStatusEffectEx(xi.effect.VORSEAL, xi.effect.VORSEAL, 0, 3600, 0)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
end

return zoneObject

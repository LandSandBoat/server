-----------------------------------
--
-- Zone: Promyvion-Holla (16)
--
-----------------------------------
local ID = require("scripts/zones/Promyvion-Holla/IDs")
require("scripts/globals/promyvion")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    xi.promyvion.initZone(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(92.033, 0, 80.380, 255) -- To Floor 1 {R}
    end

    if player:getCurrentMission(COP) == xi.mission.id.cop.BELOW_THE_ARKS and player:getCharVar("PromathiaStatus") == 2 then
        player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.BELOW_THE_ARKS)
        player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_MOTHERCRYSTALS) -- start mission 1.3
        player:setCharVar("PromathiaStatus", 0)
    elseif player:getCurrentMission(COP) == xi.mission.id.cop.THE_MOTHERCRYSTALS then
        if player:hasKeyItem(xi.ki.LIGHT_OF_DEM) and player:hasKeyItem(xi.ki.LIGHT_OF_MEA) then
            if player:getCharVar("cslastpromy") == 1 then
                player:setCharVar("cslastpromy", 0)
                cs = 52
            end
        elseif player:hasKeyItem(xi.ki.LIGHT_OF_DEM) or player:hasKeyItem(xi.ki.LIGHT_OF_MEA) then
            if player:getCharVar("cs2ndpromy") == 1 then
                player:setCharVar("cs2ndpromy", 0)
                cs = 51
            end
        end
    end

    if player:getCharVar("FirstPromyvionHolla") == 1 then
        cs = 50
    end

    return cs
end

zone_object.afterZoneIn = function(player)
    if xi.settings.ENABLE_COP_ZONE_CAP == 1 then
        player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, 30, 0, 0)
    end
end

zone_object.onRegionEnter = function(player, region)
    xi.promyvion.onRegionEnter(player, region)
end

zone_object.onRegionLeave = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 46 and option == 1 then
        player:setPos(-225.682, -6.459, 280.002, 128, 14) -- To Hall of Transference {R}
    elseif csid == 50 then
        player:setCharVar("FirstPromyvionHolla", 0)
    end
end

return zone_object

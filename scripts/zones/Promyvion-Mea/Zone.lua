-----------------------------------
--
-- Zone: Promyvion-Mea (20)
--
-----------------------------------
local ID = require("scripts/zones/Promyvion-Mea/IDs")
require("scripts/globals/promyvion")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    tpz.promyvion.initZone(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-93.268, 0, 170.749, 162) -- Floor 1 {R}
    end

    if player:getCurrentMission(COP) == tpz.mission.id.cop.BELOW_THE_ARKS and player:getCharVar("PromathiaStatus") == 2 then
        player:completeMission(tpz.mission.log_id.COP, tpz.mission.id.cop.BELOW_THE_ARKS)
        player:addMission(tpz.mission.log_id.COP, tpz.mission.id.cop.THE_MOTHERCRYSTALS)
        player:setCharVar("PromathiaStatus", 0)
    elseif player:getCurrentMission(COP) == tpz.mission.id.cop.THE_MOTHERCRYSTALS then
        if player:hasKeyItem(tpz.ki.LIGHT_OF_HOLLA) and player:hasKeyItem(tpz.ki.LIGHT_OF_DEM) then
            if player:getCharVar("cslastpromy") == 1 then
                player:setCharVar("cslastpromy", 0)
                cs = 52
            end
        elseif player:hasKeyItem(tpz.ki.LIGHT_OF_HOLLA) or player:hasKeyItem(tpz.ki.LIGHT_OF_DEM) then
            if player:getCharVar("cs2ndpromy") == 1 then
                player:setCharVar("cs2ndpromy", 0)
                cs = 51
            end
        end
    end

    if player:getCharVar("FirstPromyvionMea") == 1 then
        cs = 50
    end

    return cs
end

zone_object.afterZoneIn = function(player)
    if ENABLE_COP_ZONE_CAP == 1 then
        player:addStatusEffect(tpz.effect.LEVEL_RESTRICTION, 30, 0, 0)
    end
end

zone_object.onRegionEnter = function(player, region)
    tpz.promyvion.onRegionEnter(player, region)
end

zone_object.onRegionLeave = function(player, region)
end

zone_object.onEventUpdate = function(player, region)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 46 and option == 1 then
        player:setPos(279.988, -86.459, -25.994, 63, 14) -- To Hall of Transferance {R}
    elseif csid == 50 then
        player:setCharVar("FirstPromyvionMea", 0)
    end
end

return zone_object

-----------------------------------
--
-- Zone: AlTaieu (33)
--
-----------------------------------
require("scripts/globals/settings")
local ID = require("scripts/zones/AlTaieu/IDs")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-25, -1 , -620 , 33)
    end
    if (player:getCurrentMission(COP) == xi.mission.id.cop.GARDEN_OF_ANTIQUITY and player:getCharVar("PromathiaStatus") == 0) then
        cs=1
    elseif (player:getCurrentMission(COP) == xi.mission.id.cop.DAWN and player:getCharVar("PromathiaStatus") == 0) then
        cs=167
    end
    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if (csid == 1) then
        local copCraigLights = -- Nag'molada steals one random light
        {
            xi.ki.LIGHT_OF_HOLLA,
            xi.ki.LIGHT_OF_DEM,
            xi.ki.LIGHT_OF_MEA
        }
        player:setCharVar("PromathiaStatus", 1)
        player:delKeyItem(xi.ki.MYSTERIOUS_AMULET_DRAINED)
        player:addKeyItem(xi.ki.LIGHT_OF_ALTAIEU)
        player:messageSpecial(ID.text.AMULET_SHATTERED, xi.ki.MYSTERIOUS_AMULET)
        player:messageSpecial(ID.text.LIGHT_STOLEN, copCraigLights[math.random(#copCraigLights)])
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LIGHT_OF_ALTAIEU)
        player:addTitle(xi.title.SEEKER_OF_THE_LIGHT)
    elseif (csid == 167) then
        player:setCharVar("PromathiaStatus", 1)
        player:delKeyItem(xi.ki.MYSTERIOUS_AMULET_PRISHE)
        player:messageSpecial(ID.text.RETURN_AMULET_TO_PRISHE, xi.ki.MYSTERIOUS_AMULET)
    end
end

return zone_object

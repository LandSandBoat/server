-----------------------------------
--
-- Zone: North_Gustaberg (106)
--
-----------------------------------
local ID = require("scripts/zones/North_Gustaberg/IDs")
require("scripts/quests/i_can_hear_a_rainbow")
require("scripts/globals/chocobo_digging")
require("scripts/globals/conquest")
require("scripts/globals/missions")
-----------------------------------
local zone_object = {}

zone_object.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

zone_object.onInitialize = function(zone)
    xi.conq.setRegionalConquestOverseers(zone:getRegionID())
    xi.voidwalker.zoneOnInit(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-518.867, 35.538, 588.64, 50)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 244
    elseif player:getCurrentMission(WINDURST) == xi.mission.id.windurst.VAIN and player:getMissionStatus(player:getNation()) == 1 then
        cs = 246
    end

    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
    if csid == 244 then
        quests.rainbow.onEventUpdate(player)
    elseif csid == 246 then
        if player:getZPos() > 461 then
            player:updateEvent(0, 0, 0, 0, 0, 6)
        elseif player:getXPos() > -240 then
            player:updateEvent(0, 0, 0, 0, 0, 7)
        end
    end
end

zone_object.onEventFinish = function(player, csid, option)
end

return zone_object

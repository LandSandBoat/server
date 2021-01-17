-----------------------------------
--
-- Zone: East_Ronfaure (101)
--
-----------------------------------
local ID = require("scripts/zones/East_Ronfaure/IDs")
require("scripts/quests/i_can_hear_a_rainbow")
require("scripts/globals/chocobo_digging")
require("scripts/globals/conquest");
require("scripts/globals/quests")
require("scripts/globals/helm")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onChocoboDig = function(player, precheck)
    return tpz.chocoboDig.start(player, precheck)
end

zone_object.onInitialize = function(zone)
    tpz.helm.initZone(zone, tpz.helm.type.LOGGING)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(200.015, -3.187, -536.074, 187)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 21
    elseif (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.VAIN and player:getCharVar("MissionStatus") ==
        1) then
        cs = 23
    end

    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
    if csid == 21 then
        quests.rainbow.onEventUpdate(player)
    elseif (csid == 23) then
        if (player:getYPos() >= -22) then
            player:updateEvent(0, 0, 0, 0, 0, 7)
        else
            player:updateEvent(0, 0, 0, 0, 0, 6)
        end
    end
end

zone_object.onEventFinish = function(player, csid, option)
end

return zone_object

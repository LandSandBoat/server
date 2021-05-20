-----------------------------------
--
-- Zone: Wajaom_Woodlands (51)
--
-----------------------------------
local ID = require("scripts/zones/Wajaom_Woodlands/IDs")
require("scripts/globals/chocobo_digging")
require("scripts/globals/settings")
require("scripts/globals/missions")
require("scripts/globals/chocobo")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/helm")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

zone_object.onInitialize = function(zone)
    xi.helm.initZone(zone, xi.helm.type.HARVESTING)
    xi.chocobo.initZone(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        if player:getCurrentMission(TOAU) == xi.mission.id.toau.UNRAVELING_REASON then
            player:setPos(-200.036, -10, 79.948, 254)
            cs = 11
        else
            player:setPos(610.542, -28.547, 356.247, 122)
        end
    elseif player:getCharVar("threemenandaclosetCS") == 2 and prevZone == xi.zone.AHT_URHGAN_WHITEGATE then
        cs = 510
    end
    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
    -- printf("Update CSID: %u", csid)
    -- printf("Update RESULT: %u", option)
end

zone_object.onEventFinish = function(player, csid, option)
    -- printf("Finish CSID: %u", csid)
    -- printf("Finish RESULT: %u", option)
    if csid == 510 then
        player:setCharVar("threemenandaclosetCS", 3)
    elseif csid == 11 then
        player:startEvent(21)
    elseif csid == 21 then
        player:startEvent(22)
    elseif csid == 22 then
        player:completeMission(xi.mission.log_id.TOAU, xi.mission.id.toau.UNRAVELING_REASON)
        player:setTitle(xi.title.ENDYMION_PARATROOPER)
        player:setCharVar("TOAUM40_STARTDAY", 0)
        player:addMission(xi.mission.log_id.TOAU, xi.mission.id.toau.LIGHT_OF_JUDGMENT)
    end
end

return zone_object

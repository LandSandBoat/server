-----------------------------------
--
-- Zone: La_Theine_Plateau (102)
--
-----------------------------------
local ID = require("scripts/zones/La_Theine_Plateau/IDs")
require("scripts/zones/La_Theine_Plateau/globals")
require("scripts/quests/i_can_hear_a_rainbow")
require("scripts/globals/chocobo_digging")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/chocobo")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

zone_object.onInitialize = function(zone)
    LA_THEINE_PLATEAU.moveFallenEgg()
    xi.chocobo.initZone(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos( -272.118, 21.715, 98.859, 243)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 123
    elseif (prevZone == xi.zone.ORDELLES_CAVES and player:getCharVar("darkPuppetCS") == 5 and player:getFreeSlotsCount() >= 1) then
        cs = 122
    elseif (player:getCurrentMission(WINDURST) == xi.mission.id.windurst.VAIN and player:getCharVar("MissionStatus") ==1) then
        cs = 125
    end

    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
    if (csid == 123) then
        quests.rainbow.onEventUpdate(player)
    elseif (csid == 125) then
        player:updateEvent(0, 0, 0, 0, 0, 2)
    end
end

zone_object.onEventFinish = function(player, csid, option)
    if (csid == 122) then
        npcUtil.completeQuest(player, BASTOK, xi.quest.id.bastok.DARK_PUPPET, {item=14096, fame=40, var="darkPuppetCS"}) -- Chaos Sollerets
    end
end

zone_object.onZoneWeatherChange = function(weather)
    local rainbow = GetNPCByID(ID.npc.RAINBOW)
    local TOTD = VanadielTOTD()
    local setRainbow = rainbow:getLocalVar("setRainbow")

    if (setRainbow == 1 and weather ~= xi.weather.RAIN and TOTD >= xi.time.DAWN and TOTD <= xi.time.EVENING and rainbow:getAnimation() == xi.anim.CLOSE_DOOR) then
        rainbow:setAnimation(xi.anim.OPEN_DOOR)
    elseif (setRainbow == 1 and weather == xi.weather.RAIN and rainbow:getAnimation() == xi.anim.OPEN_DOOR) then
        rainbow:setAnimation(xi.anim.CLOSE_DOOR)
        rainbow:setLocalVar('setRainbow', 0)
    end
end

zone_object.onTOTDChange = function(TOTD)
    local rainbow = GetNPCByID(ID.npc.RAINBOW)
    local setRainbow = rainbow:getLocalVar("setRainbow")

    if (setRainbow == 1 and TOTD >= xi.time.DAWN and TOTD <= xi.time.EVENING and rainbow:getAnimation() == xi.anim.CLOSE_DOOR) then
        rainbow:setAnimation(xi.anim.OPEN_DOOR)
    elseif (setRainbow == 1 and TOTD < xi.time.DAWN or TOTD > xi.time.EVENING and rainbow:getAnimation() == xi.anim.OPEN_DOOR) then
        rainbow:setAnimation(xi.anim.CLOSE_DOOR)
        rainbow:setLocalVar('setRainbow', 0)
    end
end

return zone_object

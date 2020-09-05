-----------------------------------
--
-- Zone: La_Theine_Plateau (102)
--
-----------------------------------
local ID = require("scripts/zones/La_Theine_Plateau/IDs")
require("scripts/zones/La_Theine_Plateau/globals")
require("scripts/globals/icanheararainbow")
require("scripts/globals/chocobo_digging")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/chocobo")
require("scripts/globals/weather")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/zone")
-----------------------------------

function onChocoboDig(player, precheck)
    return tpz.chocoboDig.start(player, precheck)
end

function onInitialize(zone)
    LA_THEINE_PLATEAU.moveFallenEgg()
    tpz.chocobo.initZone(zone)
end

function onZoneIn( player, prevZone)
    local cs = -1

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos( -272.118, 21.715, 98.859, 243)
    end

    if (triggerLightCutscene(player)) then -- Quest: I Can Hear A Rainbow
        cs = 123
    elseif (prevZone == tpz.zone.ORDELLES_CAVES and player:getCharVar("darkPuppetCS") == 5 and player:getFreeSlotsCount() >= 1) then
        cs = 122
    elseif (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.VAIN and player:getCharVar("MissionStatus") ==1) then
        cs = 125
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter( player, region)
end

function onEventUpdate( player, csid, option)
    if (csid == 123) then
        lightCutsceneUpdate(player) -- Quest: I Can Hear A Rainbow
    elseif (csid == 125) then
        player:updateEvent(0, 0, 0, 0, 0, 2)
    end
end

function onEventFinish( player, csid, option)
    if (csid == 123) then
        lightCutsceneFinish(player) -- Quest: I Can Hear A Rainbow
    elseif (csid == 122) then
        npcUtil.completeQuest(player, BASTOK, tpz.quest.id.bastok.DARK_PUPPET, {item=14096, fame=40, var="darkPuppetCS"}) -- Chaos Sollerets
    end
end

function onZoneWeatherChange(weather)
    local rainbow = GetNPCByID(ID.npc.RAINBOW)
    local TOTD = VanadielTOTD()
    local I_Can_Hear_a_Rainbow = GetServerVariable("I_Can_Hear_a_Rainbow")

    if (I_Can_Hear_a_Rainbow == 1 and weather ~= tpz.weather.RAIN and TOTD >= tpz.time.DAWN and TOTD <= tpz.time.EVENING and rainbow:getAnimation() == tpz.anim.CLOSE_DOOR) then
        rainbow:setAnimation(tpz.anim.OPEN_DOOR)
    elseif (I_Can_Hear_a_Rainbow == 1 and weather == tpz.weather.RAIN and rainbow:getAnimation() == tpz.anim.OPEN_DOOR) then
        rainbow:setAnimation(tpz.anim.CLOSE_DOOR)
        SetServerVariable("I_Can_Hear_a_Rainbow", 0)
    end
end

function onTOTDChange(TOTD)
    local rainbow = GetNPCByID(ID.npc.RAINBOW)
    local I_Can_Hear_a_Rainbow = GetServerVariable("I_Can_Hear_a_Rainbow")

    if (I_Can_Hear_a_Rainbow == 1 and TOTD >= tpz.time.DAWN and TOTD <= tpz.time.EVENING and rainbow:getAnimation() == tpz.anim.CLOSE_DOOR) then
        rainbow:setAnimation(tpz.anim.OPEN_DOOR)
    elseif (I_Can_Hear_a_Rainbow == 1 and TOTD < tpz.time.DAWN or TOTD > tpz.time.EVENING and rainbow:getAnimation() == tpz.anim.OPEN_DOOR) then
        rainbow:setAnimation(tpz.anim.CLOSE_DOOR)
        SetServerVariable("I_Can_Hear_a_Rainbow", 0)
    end
end

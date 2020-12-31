-----------------------------------
--
-- Zone: Middle_Delkfutts_Tower
--
-----------------------------------
local ID = require("scripts/zones/Middle_Delkfutts_Tower/IDs")
require("scripts/globals/conquest")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/treasure")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onInitialize(zone)
    zone:registerRegion(1, -36, -50, 83,  -30, -49,  89 ) -- Fourth Floor G-6 porter to Lower Delkfutt's Tower
    zone:registerRegion(2, -49, -50, -50, -43, -49, -43 ) -- Fourth Floor G-6 porter to Lower Delkfutt's Tower "1"
    zone:registerRegion(3, 103, -50, 10,  109, -49,  16 ) -- Fourth Floor J-6 porter to Lower Delkfutt's Tower "2"
    zone:registerRegion(4, -49, -82, -48, -43, -81, -43 ) -- Sixth Floor F-10 porter to Seventh Floor "G"
    zone:registerRegion(5, -489, -98, -48, -483, -97, -43 ) -- Seventh Floor F-10 porter to Sixth Floor "G"
    zone:registerRegion(6,  83,  -82, -48, 89, -81, -43 ) -- Sixth Floor J-10 porter to Seventh Floor "H"
    zone:registerRegion(7, -356, -98, -48, -351, -97, -43 ) -- Seventh Floor J-10 porter to Sixth Floor "H"
    zone:registerRegion(8,  84,  -82, 83,  89, -81,  89 ) -- Sixth Floor J-6 porter to Seventh Floor "I"
    zone:registerRegion(9, -356, -98, 84, -351, -97,  88 ) -- Seventh Floor  J-6 porter to Sixth Floor "I"
    zone:registerRegion(10, -415, -98, 104, -411, -97, 108 ) -- Seventh Floor  H-6 porter to Sixth Floor "J"
    zone:registerRegion(11, -489, -130, 84, -484, -129, 88 ) -- Ninth Floor F-6 porter to Upper Delkfutt's Tower

    tpz.treasure.initZone(zone)
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-43.0914, -47.4255, 77.5126, 120)
    end
    return cs
end

function onRegionEnter(player, region)
    local regionId = region:GetRegionID()
    if regionId == 8 and player:getQuestStatus(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.BLADE_OF_EVIL) == QUEST_ACCEPTED and player:getCharVar("bladeOfEvilCS") == 1 then
        player:startEvent(14)
    else
        player:startEvent(regionId - 1)
    end
end

function onRegionLeave(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- teleporters
    if csid <= 11 and option == 1 then
        if csid == 0 then
            player:setPos(412, -32, 80, 100, 184)
        elseif csid == 1 then
            player:setPos(388, -32, -40, 231, 184)
        elseif csid == 2 then
            player:setPos(540, -32, 20, 128, 184)
        elseif csid == 10 then
            player:setPos(-355, -144, 91, 64, 158)
        end

    -- BLADE OF EVIL
    elseif csid == 14 and option == 0 and npcUtil.completeQuest(player, BASTOK, tpz.quest.id.bastok.BLADE_OF_EVIL, {item=12516, title=tpz.title.PARAGON_OF_DARK_KNIGHT_EXCELLENCE, fame=60}) then
        player:setCharVar("bladeOfEvilCS", 0)
    end
end

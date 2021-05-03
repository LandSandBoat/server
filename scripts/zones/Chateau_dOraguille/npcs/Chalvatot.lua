-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Chalvatot
-- Finish Mission "The Crystal Spring"
-- Start & Finishes Quests: Her Majesty's Garden
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos -105 0.1 72 233
-----------------------------------
local ID = require("scripts/zones/Chateau_dOraguille/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local herMajestysGarden = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.HER_MAJESTY_S_GARDEN)

    -- HER MAJESTY'S GARDEN (derfland humus)
    if (herMajestysGarden == QUEST_ACCEPTED and trade:hasItemQty(533, 1) and trade:getItemCount() == 1) then
        player:startEvent(83)

    end
end

entity.onTrigger = function(player, npc)
    local currentMission = player:getCurrentMission(SANDORIA)
    local missionStatus = player:getMissionStatus(player:getNation())
    local circleOfTime = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_CIRCLE_OF_TIME)
    local circleProgress = player:getCharVar("circleTime")
    local lureOfTheWildcat = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT)
    local WildcatSandy = player:getCharVar("WildcatSandy")
    local herMajestysGarden = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.HER_MAJESTY_S_GARDEN)

    -- THE CRYSTAL SPRING (San d'Oria 3-2)
    if (currentMission == xi.mission.id.sandoria.THE_CRYSTAL_SPRING and missionStatus == 3) then
        player:startEvent(556)

    -- LEAUTE'S LAST WISHES (San d'Oria 6-1)
    elseif (currentMission == xi.mission.id.sandoria.LEAUTE_S_LAST_WISHES and missionStatus == 4 and player:hasKeyItem(xi.ki.DREAMROSE)) then
        player:startEvent(111)

    -- CIRCLE OF TIME (Bard AF3)
    elseif (circleOfTime == QUEST_ACCEPTED) then
        if (circleProgress == 5) then
            player:startEvent(99)
        elseif (circleProgress == 6) then
            player:startEvent(98)
        elseif (circleProgress == 7) then
            player:startEvent(97)
        elseif (circleProgress == 9) then
            player:startEvent(96)
        end

    -- LURE OF THE WILDCAT
    elseif (lureOfTheWildcat == QUEST_ACCEPTED and not utils.mask.getBit(WildcatSandy, 19)) then
        player:startEvent(561)

    -- HER MAJESTY'S GARDEN
    elseif (herMajestysGarden == QUEST_AVAILABLE and player:getFameLevel(SANDORIA) >= 4) then
        player:startEvent(84)
    elseif (herMajestysGarden == QUEST_ACCEPTED) then
        player:startEvent(82)

    -- DEFAULT DIALOG
    else
        player:startEvent(531)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- SAN D'ORIA MISSIONS
    if (csid == 556 or csid == 111) then
        finishMissionTimeline(player, 3, csid, option)

    -- CIRCLE OF TIME
    elseif (csid == 99 and option == 0) then
        player:setCharVar("circleTime", 6)
    elseif ((csid == 98 or csid == 99) and option == 1) then
        player:setCharVar("circleTime", 7)
        player:addKeyItem(xi.ki.MOON_RING)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MOON_RING)
    elseif (csid == 96) then
        if (player:getFreeSlotsCount() ~= 0) then
            player:addItem(12647)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 12647)
            player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_CIRCLE_OF_TIME)
            player:addTitle(xi.title.PARAGON_OF_BARD_EXCELLENCE)
            player:setCharVar("circleTime", 0)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED)
        end

    -- LURE OF THE WILDCAT
    elseif (csid == 561) then
        player:setCharVar("WildcatSandy", utils.mask.setBit(player:getCharVar("WildcatSandy"), 19, true))

    -- HER MAJESTY'S GARDEN
    elseif (csid == 84 and option == 1) then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.HER_MAJESTY_S_GARDEN)
    elseif (csid == 83) then
        player:tradeComplete()
        player:addKeyItem(xi.ki.MAP_OF_THE_NORTHLANDS_AREA)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MAP_OF_THE_NORTHLANDS_AREA)
        player:addFame(SANDORIA, 30)
        player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.HER_MAJESTY_S_GARDEN)

    end
end

return entity

-----------------------------------
-- Area: Selbina
--  NPC: Oswald
-- Starts and Finishes Quest: Under the sea (finish), The gift, The real gift
-- !pos 48 -15 9 248
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
    if player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.THE_GIFT) == QUEST_ACCEPTED and npcUtil.tradeHas(trade, 4375) then
        player:startEvent(72, 0, 4375) -- Finish quest "The gift"
    elseif player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.THE_REAL_GIFT) == QUEST_ACCEPTED and npcUtil.tradeHas(trade, 4484) then
        player:startEvent(75) -- Finish quest "The real gift"
    end
end

function onTrigger(player, npc)
    underTheSea  = player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.UNDER_THE_SEA)
    theSandCharm = player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.THE_SAND_CHARM)
    theGift      = player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.THE_GIFT)
    theRealGift  = player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.THE_REAL_GIFT)

    if player:getCharVar("underTheSeaVar") == 1 then
        player:startEvent(32) -- During quest "Under the sea" - 1st dialog
    elseif player:hasKeyItem(tpz.ki.ETCHED_RING) then
        player:startEvent(37) -- Finish quest "Under the sea"
    elseif underTheSea == QUEST_COMPLETED and theSandCharm == QUEST_AVAILABLE then
        player:startEvent(38) -- New dialog after "Under the sea"
    elseif underTheSea == QUEST_COMPLETED and theSandCharm ~= QUEST_AVAILABLE and theGift == QUEST_AVAILABLE then
        player:startEvent(70, 4375) -- Start quest "The gift"
    elseif theGift == QUEST_ACCEPTED then
        player:startEvent(71) -- During quest "The gift"
    elseif theGift == QUEST_COMPLETED and theSandCharm == QUEST_ACCEPTED then
        player:startEvent(78) -- New dialog after "The gift"
    elseif theGift == QUEST_COMPLETED and theSandCharm == QUEST_COMPLETED and theRealGift == QUEST_AVAILABLE then
        player:startEvent(73, 4484) -- Start quest "The real gift"
    elseif theRealGift == QUEST_ACCEPTED then
        player:startEvent(74, 4484) -- During quest "The real gift"
    elseif theRealGift == QUEST_COMPLETED then
        player:startEvent(76) -- Final dialog after "The real gift"
    else
        player:startEvent(30) -- Standard dialog
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 32 then
        player:setCharVar("underTheSeaVar", 2)
    elseif csid == 37 and npcUtil.completeQuest(player, OTHER_AREAS_LOG, tpz.quest.id.otherAreas.UNDER_THE_SEA, {item = 13335, fame_area = SELBINA, title = tpz.title.LIL_CUPID, var = "underTheSeaVar"}) then
        player:delKeyItem(tpz.ki.ETCHED_RING)
    elseif csid == 70 and option == 50 then
        player:addQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.THE_GIFT)
    elseif csid == 72 and npcUtil.completeQuest(player, OTHER_AREAS_LOG, tpz.quest.id.otherAreas.THE_GIFT, {item = 16497, fame_area = SELBINA, title = tpz.title.SAVIOR_OF_LOVE}) then
        player:confirmTrade()
    elseif csid == 73 and option == 50 then
        player:addQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.THE_REAL_GIFT)
    elseif csid == 75 and npcUtil.completeQuest(player, OTHER_AREAS_LOG, tpz.quest.id.otherAreas.THE_REAL_GIFT, {item = 17385, fame_area = SELBINA, title = tpz.title.THE_LOVE_DOCTOR}) then
        player:confirmTrade()
    end
end

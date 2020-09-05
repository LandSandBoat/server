-----------------------------------
-- Area: Lower Jeuno
--  NPC: Vola
-- Starts and Finishes Quest: Fistful of Fury
-- Involved in Quests: Beat Around the Bushin (before the quest)
-- !pos 43 3 -45 245
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Lower_Jeuno/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    FistfulOfFury = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.FISTFUL_OF_FURY)

    if (FistfulOfFury == QUEST_ACCEPTED and trade:hasItemQty(1012, 1) == true and trade:hasItemQty(1013, 1) == true and trade:hasItemQty(1014, 1) == true and trade:getItemCount() == 3) then
        player:startEvent(213) -- Finish Quest "Fistful of Fury"
    end
end

function onTrigger(player, npc)
    FistfulOfFury = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.FISTFUL_OF_FURY)
    BeatAroundTheBushin = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.BEAT_AROUND_THE_BUSHIN)

    if (player:getFameLevel(NORG) >= 3 and FistfulOfFury == QUEST_AVAILABLE and player:getQuestStatus(BASTOK, tpz.quest.id.bastok.SILENCE_OF_THE_RAMS) == QUEST_COMPLETED) then
        player:startEvent(216) -- Start Quest "Fistful of Fury"
    elseif (FistfulOfFury == QUEST_ACCEPTED) then
        player:startEvent(215) -- During Quest "Fistful of Fury"
    elseif (BeatAroundTheBushin == QUEST_AVAILABLE and player:getMainJob() == tpz.job.MNK and player:getMainLvl() >= 71 and player:getFameLevel(NORG) >= 6) then
        player:startEvent(160) -- Start Quest "Beat Around the Bushin"
    elseif (BeatAroundTheBushin ~= QUEST_AVAILABLE) then
        player:startEvent(214) -- During & After Quest "Beat Around the Bushin"
    else
        player:startEvent(212) -- Standard dialog
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 216 and option == 1) then
        player:addQuest(JEUNO, tpz.quest.id.jeuno.FISTFUL_OF_FURY)
    elseif (csid == 213) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 13202)
        else
            player:addTitle(tpz.title.BROWN_BELT)
            player:addItem(13202)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 13202)
            player:addFame(NORG, 125)
            player:tradeComplete()
            player:completeQuest(JEUNO, tpz.quest.id.jeuno.FISTFUL_OF_FURY)
        end
    elseif (csid == 160 and player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.BEAT_AROUND_THE_BUSHIN) == QUEST_AVAILABLE) then
        player:setCharVar("BeatAroundTheBushin", 1) -- For the next quest "Beat around the Bushin"
    end
end

-----------------------------------
-- Area: Selbina
--  NPC: Yaya
-- Starts Quest: Under the sea
-- !pos -19 -2 -16 248
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getFameLevel(SELBINA) >= 2 and player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.UNDER_THE_SEA) == QUEST_AVAILABLE then
        player:startEvent(31) -- Start quest "Under the sea"
    else
        player:startEvent(153) -- Standard dialog
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 31 then
        player:addQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.UNDER_THE_SEA)
        player:setCharVar("underTheSeaVar", 1)
    end
end

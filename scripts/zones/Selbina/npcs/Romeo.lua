-----------------------------------
-- Area: Selbina
--  NPC: Romeo
-- Starts and Finishes Quest: Donate to Recycling
-- !pos -11 -11 -6 248
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
    if
        player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.DONATE_TO_RECYCLING) == QUEST_ACCEPTED and
        (
            npcUtil.tradeHas(trade, {{16482, 5}}) or
            npcUtil.tradeHas(trade, {{16483, 5}}) or
            npcUtil.tradeHas(trade, {{16534, 5}}) or
            npcUtil.tradeHas(trade, {{17068, 5}}) or
            npcUtil.tradeHas(trade, {{17104, 5}})
        )
    then
        player:startEvent(21) -- Finish quest "Donate to Recycling"
    end
end

function onTrigger(player, npc)
    donateToRecycling = player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.DONATE_TO_RECYCLING)

    if donateToRecycling == QUEST_AVAILABLE then
        player:startEvent(20) -- Start quest "Donate to Recycling"
    elseif donateToRecycling == QUEST_ACCEPTED then
        player:startEvent(22) -- During quest "Donate to Recycling"
    else
        player:startEvent(23) -- Standard dialog
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 20 then
        player:addQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.DONATE_TO_RECYCLING)
    elseif csid == 21 and npcUtil.completeQuest(player, OTHER_AREAS_LOG, tpz.quest.id.otherAreas.DONATE_TO_RECYCLING, {item = 89, fame_area = SELBINA, title = tpz.title.ECOLOGIST}) then
        player:confirmTrade()
    end
end

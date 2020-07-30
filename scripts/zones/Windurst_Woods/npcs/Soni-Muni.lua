-----------------------------------
-- Area: Windurst Woods
--  NPC: Soni-Muni
-- Starts & Finishes Quest: The Amazin' Scorpio
-- !pos -17.073 1.749 -59.327 241
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
    if player:getQuestStatus(WINDURST, tpz.quest.id.windurst.THE_AMAZIN_SCORPIO) == QUEST_ACCEPTED and npcUtil.tradeHas(trade, 1017) then
        player:startEvent(484)
    end
end

function onTrigger(player, npc)
    local amazinScorpio = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.THE_AMAZIN_SCORPIO)
    local wildcatWindurst = player:getCharVar("WildcatWindurst")

    if player:getQuestStatus(WINDURST, tpz.quest.id.windurst.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not player:getMaskBit(wildcatWindurst, 0) then
        player:startEvent(735)
    elseif amazinScorpio == QUEST_COMPLETED then
        player:startEvent(485)
    elseif amazinScorpio == QUEST_ACCEPTED then
        player:startEvent(482, 0, 0, 1017)
    elseif amazinScorpio == QUEST_AVAILABLE and player:getFameLevel(WINDURST) >= 2 then
        player:startEvent(481, 0, 0, 1017)
    else
        player:startEvent(421)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 481 then
        player:addQuest(WINDURST, tpz.quest.id.windurst.THE_AMAZIN_SCORPIO)
    elseif csid == 484 and npcUtil.completeQuest(player, WINDURST, tpz.quest.id.windurst.THE_AMAZIN_SCORPIO, {fame=80, title=tpz.title.GREAT_GRAPPLER_SCORPIO, gil=1500}) then
        player:confirmTrade()
    elseif csid == 735 then
        player:setMaskBit(player:getCharVar("WildcatWindurst"), "WildcatWindurst", 0, true)
    end
end

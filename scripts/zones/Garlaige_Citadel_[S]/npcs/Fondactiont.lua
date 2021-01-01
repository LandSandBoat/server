-----------------------------------
-- Area: Garlaige Citadel [S]
--  NPC: Fondactiont
-- Starts and Finishes Quest: The Fumbling Friar
-- !pos -95 0 196 164
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local TheFumblingFriar = player:getQuestStatus(tpz.quest.log_id.CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_FUMBLING_FRIAR)

    -- Change to BRASS_RIBBON_OF_SERVICE later when Campaign has been added.
    if TheFumblingFriar == QUEST_AVAILABLE and player:hasKeyItem(tpz.ki.BRONZE_RIBBON_OF_SERVICE) and player:getMainLvl() >= 30 then
        player:startEvent(26) -- Start quest "The Fumbling Friar"
    elseif TheFumblingFriar == QUEST_ACCEPTED then
        if player:hasKeyItem(tpz.ki.ORNATE_PACKAGE) then
            player:startEvent(28) -- During quest "The Fumbling Friar" (with Ornate Package KI)
        else
            player:startEvent(27) -- During quest "The Fumbling Friar" (before retrieving KI Ornate Package)
        end
    elseif TheFumblingFriar == QUEST_COMPLETED then
        player:startEvent(29) -- New standard dialog after "The Fumbling Friar"
    else
        player:startEvent(25) -- Standard dialog
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 26 then
        player:addQuest(tpz.quest.log_id.CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_FUMBLING_FRIAR)
    elseif csid == 28 and npcUtil.completeQuest(player, CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_FUMBLING_FRIAR, {item = 4688}) then
        player:delKeyItem(tpz.ki.ORNATE_PACKAGE)
    end
end

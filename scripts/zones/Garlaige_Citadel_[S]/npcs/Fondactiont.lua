-----------------------------------
-- Area: Garlaige Citadel [S]
--  NPC: Fondactiont
-- Starts and Finishes Quest: The Fumbling Friar
-- !pos -95 0 196 164
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local theFumblingFriar = player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_FUMBLING_FRIAR)

    -- Change to BRASS_RIBBON_OF_SERVICE later when Campaign has been added.
    if
        theFumblingFriar == xi.questStatus.QUEST_AVAILABLE and
        player:hasKeyItem(xi.ki.BRONZE_RIBBON_OF_SERVICE) and
        player:getMainLvl() >= 30
    then
        player:startEvent(26) -- Start quest "The Fumbling Friar"
    elseif theFumblingFriar == xi.questStatus.QUEST_ACCEPTED then
        if player:hasKeyItem(xi.ki.ORNATE_PACKAGE) then
            player:startEvent(28) -- During quest "The Fumbling Friar" (with Ornate Package KI)
        else
            player:startEvent(27) -- During quest "The Fumbling Friar" (before retrieving KI Ornate Package)
        end
    elseif theFumblingFriar == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(29) -- New standard dialog after "The Fumbling Friar"
    else
        player:startEvent(25) -- Standard dialog
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 26 then
        player:addQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_FUMBLING_FRIAR)
    elseif
        csid == 28 and
        npcUtil.completeQuest(player, xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_FUMBLING_FRIAR, { item = xi.item.SCROLL_OF_RECALL_PASHH })
    then
        player:delKeyItem(xi.ki.ORNATE_PACKAGE)
    end
end

return entity

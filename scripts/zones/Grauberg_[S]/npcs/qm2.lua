-----------------------------------
-- Area: Grauberg [S]
--  NPC: qm2 (???)
-- Involved In Quest: The Fumbling Friar
-- !pos 80 -1 457 89
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_FUMBLING_FRIAR) == xi.questStatus.QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.ORNATE_PACKAGE)
    then
        npcUtil.giveKeyItem(player, xi.ki.ORNATE_PACKAGE)
    end
end

return entity

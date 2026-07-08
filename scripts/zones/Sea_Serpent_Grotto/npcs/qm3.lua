-----------------------------------
-- Area: Sea Serpent Grotto
--  NPC: ??? Used for Norg quest "It's not your vault"
-- !pos -173 26 252 176
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.ITS_NOT_YOUR_VAULT) == xi.questStatus.QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.SEALED_IRON_BOX)
    then
        npcUtil.giveKeyItem(player, xi.ki.SEALED_IRON_BOX)
    end
end

return entity

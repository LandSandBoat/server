-----------------------------------
-- Area: Fei'Yin
--  NPC: Treasure Chest
-- !zone 204
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.SORCERY_OF_THE_NORTH) == xi.questStatus.QUEST_ACCEPTED and
        not player:hasKeyItem(xi.keyItem.FEIYIN_MAGIC_TOME)
    then
        xi.treasure.onTrade(player, npc, trade, 2, xi.keyItem.FEIYIN_MAGIC_TOME)
    else
        xi.treasure.onTrade(player, npc, trade, 0, 0)
    end
end

entity.onTrigger = function(player, npc)
    xi.treasure.onTrigger(player, npc)
end

return entity

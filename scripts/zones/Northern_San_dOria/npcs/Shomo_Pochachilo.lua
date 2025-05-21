-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Shomo Pochachilo
-- !pos 28.369 -0.199 30.061 231
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- TODO: Verify this, and move to quest script
    local questFatherAndSon = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.FATHER_AND_SON)

    if questFatherAndSon == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(696)
    else
        player:startEvent(675)
    end
end

return entity

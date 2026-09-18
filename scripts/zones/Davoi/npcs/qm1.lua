-----------------------------------
-- Area: Davoi
--  NPC: ??? (qm1)
-- Involved in Quest: To Cure a Cough
-- !pos -115.830 -0.427 -184.289 149
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.TO_CURE_A_COUGH) == xi.questStatus.QUEST_ACCEPTED and
        not player:hasKeyItem(xi.keyItem.THYME_MOSS)
    then
        npcUtil.giveKeyItem(player, xi.keyItem.THYME_MOSS)
    end
end

return entity

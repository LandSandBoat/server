-----------------------------------
-- Area: Yahse Hunting Grounds
--  NPC: Yahse Wildflower
-- Involved in quest Children of the Rune
-- pos 370.6285 0.6692 153.3728
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- CHILDREN OF THE RUNE
    if player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.CHILDREN_OF_THE_RUNE) == xi.questStatus.QUEST_ACCEPTED then
        npcUtil.giveKeyItem(player, xi.ki.YAHSE_WILDFLOWER_PETAL)
    end
end

return entity

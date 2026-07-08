-----------------------------------
-- Area: Port Windurst
--  NPC: Five of Clubs
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.A_GREETING_CARDIAN) == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(448)
    else
        player:startEvent(221)
    end
end

return entity

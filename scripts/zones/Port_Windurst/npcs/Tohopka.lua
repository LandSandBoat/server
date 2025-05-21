-----------------------------------
-- Area: Port Windurst
-- NPC : Tohopka
-- !pos -105.723 -10 83.813 240
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local starStatus = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.TO_CATCH_A_FALLING_STAR)

    if starStatus == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(198, 0, 546, 868)
    else
        player:startEvent(358)
    end
end

return entity

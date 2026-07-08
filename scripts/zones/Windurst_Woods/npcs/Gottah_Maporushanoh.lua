-----------------------------------
-- Area: Windurst Woods
--  NPC: Gottah Maporushanoh
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local amazinScorpio = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.THE_AMAZIN_SCORPIO)

    if amazinScorpio == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(486)
    elseif amazinScorpio == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(483)
    else
        player:startEvent(420)
    end
end

return entity

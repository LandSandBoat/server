-----------------------------------
-- Area: Windurst Woods
--  NPC: Matata
-- Involved in quest: In a Stew
-- !pos 131 -5 -109 241
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local chocobilious = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.CHOCOBILIOUS)

    -- CHOCOBILIOUS
    if chocobilious == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(226) -- Chocobilious complete

    -- STANDARD DIALOG
    else
        player:startEvent(223)
    end
end

return entity

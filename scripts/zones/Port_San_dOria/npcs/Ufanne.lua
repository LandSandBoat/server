-----------------------------------
-- Area: Port San d'Oria
--  NPC: Ufanne
-- !pos -15.965 -3 -47.748 232
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local fishCountVar = player:getCharVar('theCompetitionFishCountVar')
    if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_RIVALRY) == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(309, 0, 0, fishCountVar)
    elseif player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_COMPETITION) == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(309, 1, 0, fishCountVar)
    else
        player:startEvent(310)
    end
end

return entity

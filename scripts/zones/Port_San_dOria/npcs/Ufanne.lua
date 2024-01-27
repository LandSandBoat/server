-----------------------------------
-- Area: Port San d'Oria
--  NPC: Ufanne
-- !pos -15.965 -3 -47.748 232
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local fishCountVar = player:getCharVar('theCompetitionFishCountVar')
    if player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_RIVALRY) == QUEST_ACCEPTED then
        player:startEvent(309, 0, 0, fishCountVar)
    elseif player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_COMPETITION) == QUEST_ACCEPTED then
        player:startEvent(309, 1, 0, fishCountVar)
    else
        player:startEvent(310)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity

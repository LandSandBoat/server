-----------------------------------
-- Area: Port San d'Oria
--  NPC: Ufanne
-- Type: Standard NPC
-- !pos -15.965 -3 -47.748 232
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local fishCountVar = 0
    if (player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_RIVALRY) == QUEST_ACCEPTED) then
        fishCountVar = player:getCharVar("theCompetitionFishCountVar")
        player:startEvent(309, 0, 0, fishCountVar)
    elseif (player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_COMPETITION) == QUEST_ACCEPTED) then
        fishCountVar = player:getCharVar("theCompetitionFishCountVar")
        player:startEvent(309, 1, 0, fishCountVar)
    else
        player:startEvent(310)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity

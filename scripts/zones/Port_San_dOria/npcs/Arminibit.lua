-----------------------------------
-- Area: Port San d'Oria
--  NPC: Arminibit
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getMainLvl() >= 30 and
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_HOLY_CREST) == QUEST_AVAILABLE
    then
        player:startEvent(24)
    else
        player:startEvent(587)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 24 then
        player:setCharVar("TheHolyCrest_Event", 1)
    end
end

return entity

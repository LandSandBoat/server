-----------------------------------
-- Area: Port San d'Oria
--  NPC: Arminibit
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getMainLvl() >= 30 and
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_HOLY_CREST) == xi.questStatus.QUEST_AVAILABLE
    then
        player:startEvent(24)
    else
        player:startEvent(587)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 24 then
        player:setCharVar('TheHolyCrest_Event', 1)
    end
end

return entity

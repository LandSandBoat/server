-----------------------------------
-- Area: Carpenters' Landing
--  NPC: Lourdaude
-- !pos 215.597 -2.689 -526.021 2
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(26)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity

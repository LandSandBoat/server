-----------------------------------
-- Area: Bastok Mines
--  NPC: Wobke
-- Type: Quest NPC
-- !pos 29.028 -0.126 -111.626 234
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(244)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity

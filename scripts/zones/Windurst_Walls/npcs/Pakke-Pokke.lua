-----------------------------------
-- Area: Windurst Walls
--  NPC: Pakke-Pokke
-- !pos -3.464 -17.25 125.635 239
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(89)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity

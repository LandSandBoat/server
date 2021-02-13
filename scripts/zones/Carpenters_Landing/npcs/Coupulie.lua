-----------------------------------
-- Area: Carpenters' Landing
--  NPC: Coupulie
-- Type: Standard NPC
-- !pos -313.585 -3.628 490.944 2
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(32, 618, 652, 50, 300)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity

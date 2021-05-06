-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Explorer Moogle
-- Type: Mog Tablet
-- !pos 1.000 -1 0.000 243
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(10114)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity

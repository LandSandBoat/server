-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Pursuivant
-- !pos 52.020 -1 -17.813 243
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(69)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity

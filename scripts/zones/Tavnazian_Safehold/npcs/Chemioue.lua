-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Chemioue
-- Type: NPC Quest
-- !pos 82.041 -34.964 67.636 26
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(280)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity

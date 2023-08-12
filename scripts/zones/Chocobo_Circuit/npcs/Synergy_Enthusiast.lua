-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Synergy_Enthusiast
-- !pos -324.546 0.000 -524.753 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(12001)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity

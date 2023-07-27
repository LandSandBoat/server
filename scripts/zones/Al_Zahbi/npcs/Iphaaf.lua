-----------------------------------
-- Area: Al Zahbi
--  NPC: Iphaaf
-- Type: Mihli's Attendant
-- !pos -28.014 -7 64.371 48
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(254)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity

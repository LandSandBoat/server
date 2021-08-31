-----------------------------------
-- Area: Bastok Mines
--  NPC: Ranpi-Pappi
-- Type: Standard NPC
-- !pos -4.535 -1.044 49.881 234
-----------------------------------
-- Auto-Script: Requires Verification (Verified by Brando)
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(77)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity

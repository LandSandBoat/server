-----------------------------------
-- Area: Western Adoulin
--  NPC: Gemmerick
-- Type: Standard AH Info NPC
-- !pos 79 4 26 256
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(5)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity

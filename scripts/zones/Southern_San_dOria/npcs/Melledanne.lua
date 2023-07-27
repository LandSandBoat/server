-----------------------------------
-- Area: Southern San dOria
--  NPC: Melledanne
-- Type: Melody Minstrel NPC
-- !pos -33.194 0.000 34.662 230
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(943)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity

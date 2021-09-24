-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Zidalf
-- !pos -33 0 33 80
-- Melody Minstrel
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(0)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity

-----------------------------------
-- Area: Windurst Woods
--  NPC: Pulonono
-- Type: VCS Chocobo Trainer
-- !pos 130.124 -6.35 -119.341 241
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(741)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity

-----------------------------------
-- Area: North Gustaberg
--  NPC: Goblin Footprint
-- Type: NPC
-- !pos  646.028 0.336 311.771 106
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.goblinfootprint.rewatch(player)
end

entity.onTrigger = function(player, npc)
    xi.goblinfootprint.rewatch(player, true)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.goblinfootprint.startEvent(player, csid, option, npc)
end

return entity

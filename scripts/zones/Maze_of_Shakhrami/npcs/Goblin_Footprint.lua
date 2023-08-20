-----------------------------------
-- Area: Maze of Shakhrami
--  NPC: Goblin Footprint
-- Type: NPC
-- !pos  -337.589 -12.248 -178.081 198
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

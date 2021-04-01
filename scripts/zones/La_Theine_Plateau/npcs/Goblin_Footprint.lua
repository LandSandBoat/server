-----------------------------------
-- Area: La Theine Plateau
--  NPC: Goblin Footprint
-- Type: NPC
-- !pos  -546.156 -3.934 651.590 102
-----------------------------------
require("scripts/globals/goblinfootprint")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.goblinfootprint.rewatch(player)
end

entity.onTrigger = function(player, npc)
    xi.goblinfootprint.rewatch(player, true)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.goblinfootprint.startEvent(player, csid, option)
end

return entity

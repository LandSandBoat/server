-----------------------------------
-- Area: North Gustaberg
--  NPC: Goblin Footprint
-- Type: NPC
-- !pos  646.028 0.336 311.771 106
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

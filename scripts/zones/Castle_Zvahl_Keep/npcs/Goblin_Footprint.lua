-----------------------------------
-- Area: Castle Zvahl Keep
--  NPC: Goblin Footprint
-- Type: NPC
-- !pos  45.948 -0.037 -17.059 162
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

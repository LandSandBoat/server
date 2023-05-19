-----------------------------------
-- Area: Selbina
--  NPC: Chenon
-- Type: Fish Ranking NPC
-- !pos -13.472 -8.287 9.497 248
-----------------------------------
require('scripts/globals/fish')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.fishing.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.fishing.onTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
    xi.fishing.onEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.fishing.onEventFinish(player, csid, option)
end

return entity

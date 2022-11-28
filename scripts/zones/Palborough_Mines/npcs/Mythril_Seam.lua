-----------------------------------
-- Area: Palborough Mines
--  NPC: Mythril Seam
-- Involved In Mission: Journey Abroad
-- Involved in quest: Rock Racketeer
-- !pos -68 -7 173 143
-- Rock Racketeer !pos 210 -32 -63 143
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(30, 12, 0, xi.items.CHUNK_OF_MINE_GRAVEL)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity

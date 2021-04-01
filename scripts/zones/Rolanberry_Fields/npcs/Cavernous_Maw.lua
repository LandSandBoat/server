-----------------------------------
-- Area: Rolanberry Fields
--  NPC: Cavernous Maw
-- !pos -198 8 361 110
-- Teleports Players to Rolanberry Fields [S]
-----------------------------------
require("scripts/globals/maws")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.maws.onTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.maws.onEventFinish(player, csid, option)
end

return entity

-----------------------------------
-- Area: Meriphataud Mountains
--  NPC: Cavernous Maw
-- !pos 597 -32 279 119
-- Teleports Players to Meriphataud Mountains [S]
-----------------------------------
require("scripts/globals/maws")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    tpz.maws.onTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    tpz.maws.onEventFinish(player, csid, option)
end

return entity

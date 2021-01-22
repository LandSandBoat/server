-----------------------------------
-- Area: North Gustaberg
--  NPC: Cavernous Maw
-- !pos 466 0 479 106
-- Teleports Players to North Gustaberg [S]
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

-----------------------------------
-- Area: Pashhow Marshlands [S]
--  NPC: Cavernous Maw
-- !pos 418 25 27 90
-- Teleports Players to Pashhow_Marshlands
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

-----------------------------------
-- Area: Xarcabard
--  NPC: Trail Markings
-- Dynamis-Xarcabard Enter
-- !pos 570 0 -272 112
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    dynamis.entryNpcOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    dynamis.entryNpcOnEventFinish(player, csid, option)
end

return entity

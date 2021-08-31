-----------------------------------
-- Area: Metalworks
--  NPC: Matrimonial Coffer
-- Type: NPC
-- !pos 90.079 -20.170 -12.937 237
-----------------------------------
require("scripts/globals/matrimonialcoffer")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.matrimonialcoffer.startEvent(player)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.matrimonialcoffer.finishEvent(player, csid, option)
end

return entity

-----------------------------------
-- Area: Heaven's Tower
--  NPC: Kierron
-- Type: Abyssea Warp NPC
-- !pos -7.1 0.5 -4.5 242
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.abyssea.warpNPCOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
    xi.abyssea.warpNPCOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.warpNPCOnEventFinish(player, csid, option, npc)
end

return entity

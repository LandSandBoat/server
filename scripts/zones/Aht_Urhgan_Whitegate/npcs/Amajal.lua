-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Amajal
-- Standard Info NPC
-----------------------------------
require("scripts/globals/era_npc")
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.eraNpc.giveInstantWarpScrollThenTryWarp(player, npc, {
        destinationName = "Caedarva Mire - Undead ZNM Camp",
        destination     = {-691, -24, 357, 132, xi.zone.CAEDARVA_MIRE},
    })
end

return entity
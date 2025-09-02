-----------------------------------
--  Area: Provenance
--  NPC:  Glimmering Trove
--  Warp to homepoint
-----------------------------------
require("scripts/globals/era_npc")
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.eraNpc.tryWarp(player, npc, {
        destinationName = "Your Home Point",
        destination     = "warp",
        name            = "GlimmeringTrove",
    })
end

entity.onTrade = function(player, npc, trade)
end

entity.onEventFinish = function(player, csid, option)
end

return entity

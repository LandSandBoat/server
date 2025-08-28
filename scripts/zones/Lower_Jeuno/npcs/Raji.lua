-----------------------------------
-- Area: Lower Jeuno
--  NPC: Raji
-- Standard Info NPC
-----------------------------------
require("scripts/globals/era_npc")

local entity = {}

entity.onTrigger = function(player, npc)
    xi.eraNpc.giveInstantWarpScrollThenTryWarp(player, npc, {
        destinationName = "Crawler's Nest - Lizard Camp",
        destination     = {132, -40, -70, 90, xi.zone.CRAWLERS_NEST},
    })

    -- TODO: Just delete these old vars from the DB and remove this code.
    -- Cleanup old vars.
    player:setVar("CNestCamp", 0)
    player:setVar("LJNation", 0)
end

return entity
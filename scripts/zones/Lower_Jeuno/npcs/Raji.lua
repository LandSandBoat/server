-----------------------------------
-- Area: Lower Jeuno
--  NPC: Raji
-- Standard Info NPC
-----------------------------------
require('modules/custom/lua/era_npc')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.eraNpc.giveInstantWarpScrollThenTryWarp(player, npc, {
        destinationName = 'Crawler\'s Nest - Lizard Camp',
        destination     = 
        {
            132, -40, -70, 90, xi.zone.CRAWLERS_NEST
        },
    })
end

return entity

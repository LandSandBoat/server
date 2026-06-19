-----------------------------------
-- Area: Port Jeuno
--  NPC: Naurmaire
-- Standard Info NPC
-----------------------------------
require('modules/custom/lua/era_npc')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.eraNpc.giveInstantWarpScrollThenTryWarp(player, npc,
    {
        destinationName = 'Western Altepa Desert - Beetle Camp',
        destination     =
        {
            -141, -14, 19, 255, xi.zone.WESTERN_ALTEPA_DESERT
        },
    })
end

return entity

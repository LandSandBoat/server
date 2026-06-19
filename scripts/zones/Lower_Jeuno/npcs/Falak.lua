-----------------------------------
-- Area: Port Jeuno
--  NPC: Falak
-- Standard Info NPC
-----------------------------------
require('modules/custom/lua/era_npc')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.eraNpc.giveInstantWarpScrollThenTryWarp(player, npc,
    {
        destinationName = 'Beaucedine Glacier [S] - Corse Light Camp',
        destination     =
        {
            -179.443, -83.660, -83.084, 255, xi.zone.BEAUCEDINE_GLACIER_S
        },
    })
end

return entity

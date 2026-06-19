-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Anoop
-----------------------------------
require('modules/custom/lua/era_npc')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.eraNpc.giveInstantWarpScrollThenTryWarp(player, npc,
    {
        destinationName = 'Yhoator Jungle - Mandragora Camp',
        destination     =
        {
            -285, 8, 140, 253, xi.zone.YHOATOR_JUNGLE
        },
    })
end

return entity

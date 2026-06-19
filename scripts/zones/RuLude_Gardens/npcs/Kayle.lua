-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Kayle
-----------------------------------
require('modules/custom/lua/era_npc')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.eraNpc.giveInstantWarpScrollThenTryWarp(player, npc,
    {
        destinationName = 'Kuftal Tunnel - Tiger Camp',
        destination     =
        {
            148, 19, -112, 147, xi.zone.KUFTAL_TUNNEL
        },
    })
end

return entity

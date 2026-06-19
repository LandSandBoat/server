-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Ajahkeem
-----------------------------------
require('modules/custom/lua/era_npc')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.eraNpc.giveInstantWarpScrollThenTryWarp(player, npc,
    {
        destinationName = 'The Boyahda Tree - Crab Camp',
        destination     =
        {
            215, 8, -38, 77, xi.zone.THE_BOYAHDA_TREE
        },
    })
end

return entity

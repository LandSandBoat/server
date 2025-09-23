-----------------------------------
-- Area: Lower Jeuno
--  NPC: Shomera
-- Standard Info NPC
-----------------------------------
require('modules/custom/lua/era_npc')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.eraNpc.giveInstantWarpScrollThenTryWarp(player, npc, {
        destinationName  = "Aht Urgan Whitegate",
        destination      = { 111, 0, 21, 190, xi.zone.AHT_URHGAN_WHITEGATE },
        checkFailureText = "You do not own the 'Boarding Permit' Key Item.",
        check            = function()
            return player:hasKeyItem(xi.ki.BOARDING_PERMIT)
        end,
    })
end

return entity

-----------------------------------
-- Area: Lower Jeuno
--  NPC: Shomera
-- Standard Info NPC
-----------------------------------
require("scripts/globals/era_npc")
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

    -- TODO: Just delete these old vars from the DB and remove this code.
    -- Cleanup old vars.
    player:setVar("LJGate", 0)
    player:setVar("RocCamp", 0)
end

return entity

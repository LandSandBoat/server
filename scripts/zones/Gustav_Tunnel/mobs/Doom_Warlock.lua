-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Doom Warlock
-- Note: Place holder Taxim
-----------------------------------
local ID = require("scripts/zones/Gustav_Tunnel/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 765, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 766, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 769, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.TAXIM_PH, 5, 7200) -- 2 hours
end

return entity

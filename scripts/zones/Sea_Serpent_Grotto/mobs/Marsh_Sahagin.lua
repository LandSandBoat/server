-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Marsh Sahagin
-- Note: PH for Worr the Clawfisted and Voll the Sharkfinned
-----------------------------------
local ID = require("scripts/zones/Sea_Serpent_Grotto/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 806, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 807, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 808, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.WORR_THE_CLAWFISTED_PH, 10, 7200) -- 2 hours
    xi.mob.phOnDespawn(mob, ID.mob.VOLL_THE_SHARKFINNED_PH, 10, 7200) -- 2 hours
end

return entity

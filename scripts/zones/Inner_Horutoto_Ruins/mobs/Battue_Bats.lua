-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Battue Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 647, 1, xi.regime.type.GROUNDS)
end

return entity

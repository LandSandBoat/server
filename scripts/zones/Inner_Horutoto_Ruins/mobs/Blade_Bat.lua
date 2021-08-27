-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Blade Bat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 648, 1, xi.regime.type.GROUNDS)
end

return entity

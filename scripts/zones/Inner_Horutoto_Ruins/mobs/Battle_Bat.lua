-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Battle Bat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 649, 1, xi.regime.type.GROUNDS)
end

return entity

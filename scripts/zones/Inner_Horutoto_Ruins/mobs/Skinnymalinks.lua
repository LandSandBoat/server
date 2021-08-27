-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Skinnymalinks
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 653, 2, xi.regime.type.GROUNDS)
end

return entity

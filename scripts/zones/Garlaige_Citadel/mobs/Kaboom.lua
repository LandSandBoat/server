-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Kaboom
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 709, 2, xi.regime.type.GROUNDS)
end

return entity

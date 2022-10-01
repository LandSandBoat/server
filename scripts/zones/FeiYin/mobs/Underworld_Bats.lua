-----------------------------------
-- Area: Fei'Yin
--  Mob: Underworld Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 713, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 714, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 715, 1, xi.regime.type.GROUNDS)
end

return entity

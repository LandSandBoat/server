-----------------------------------
-- Area: Ifrit's Cauldron
--  Mob: Volcanic Bomb
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 760, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 761, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 762, 2, xi.regime.type.GROUNDS)
end

return entity

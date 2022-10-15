-----------------------------------
-- Area: Temple of Uggalepih
--  Mob: Temple Bee
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 790, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 793, 2, xi.regime.type.GROUNDS)
end

return entity

-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Bilesucker
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 607, 1, xi.regime.type.GROUNDS)
end

return entity

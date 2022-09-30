-----------------------------------
-- Area: Qufim Island
--  Mob: Clipper
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 41, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 42, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 43, 2, xi.regime.type.FIELDS)
end

return entity

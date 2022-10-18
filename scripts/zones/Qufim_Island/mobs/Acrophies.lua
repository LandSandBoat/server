-----------------------------------
-- Area: Qufim Island
--  Mob: Acrophies
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 45, 1, xi.regime.type.FIELDS)
end

return entity

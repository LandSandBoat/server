-----------------------------------
-- Area: West Sarutabaruta
--  Mob: Yagudo Initiate
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 29, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 61, 1, xi.regime.type.FIELDS)
end

return entity

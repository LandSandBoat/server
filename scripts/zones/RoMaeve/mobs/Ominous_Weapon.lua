-----------------------------------
-- Area: RoMaeve
--  Mob: Ominous Weapon
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 119, 2, xi.regime.type.FIELDS)
end

return entity

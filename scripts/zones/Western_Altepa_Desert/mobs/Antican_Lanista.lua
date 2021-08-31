-----------------------------------
-- Area: Western Altepa Desert
--  Mob: Antican Lanista
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 138, 2, xi.regime.type.FIELDS)
end

return entity

-----------------------------------
-- Area: Western Altepa Desert
--  Mob: Desert Spider
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 134, 1, xi.regime.type.FIELDS)
end

return entity

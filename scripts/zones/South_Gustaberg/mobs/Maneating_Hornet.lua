-----------------------------------
-- Area: South Gustaberg
--  Mob: Maneating Hornet
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 76, 1, tpz.regime.type.FIELDS)
end

return entity

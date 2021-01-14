-----------------------------------
-- Area: Yhoator Jungle
--  Mob: Yhoator Wasp
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 130, 2, tpz.regime.type.FIELDS)
end

return entity

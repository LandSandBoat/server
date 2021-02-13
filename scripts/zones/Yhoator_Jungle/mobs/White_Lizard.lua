-----------------------------------
-- Area: Yhoator Jungle
--  Mob: White Lizard
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 129, 1, tpz.regime.type.FIELDS)
end

return entity

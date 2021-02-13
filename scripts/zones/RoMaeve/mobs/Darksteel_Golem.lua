-----------------------------------
-- Area: RoMaeve
--  Mob: Darksteel Golem
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 122, 2, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 123, 2, tpz.regime.type.FIELDS)
end

return entity

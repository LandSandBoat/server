-----------------------------------
-- Area: Buburimu Peninsula
--  Mob: Bull Dhalmel
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 34, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 35, 2, tpz.regime.type.FIELDS)
end

return entity

-----------------------------------
-- Area: Buburimu Peninsula
--  Mob: Puffer Pugil
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 62, 1, tpz.regime.type.FIELDS)
end

return entity

-----------------------------------
-- Area: Buburimu Peninsula
--  Mob: Mighty Rarab
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 32, 2, tpz.regime.type.FIELDS)
end

return entity

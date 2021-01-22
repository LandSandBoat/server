-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Robber Crab
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 809, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 810, 1, tpz.regime.type.GROUNDS)
end

return entity

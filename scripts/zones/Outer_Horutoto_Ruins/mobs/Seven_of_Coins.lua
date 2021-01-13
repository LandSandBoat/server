-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Seven of Coins
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 666, 4, tpz.regime.type.GROUNDS)
end

return entity

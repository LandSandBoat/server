-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Five of Coins
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 664, 4, tpz.regime.type.GROUNDS)
end

return entity

-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Goblin Weaver
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 648, 2, tpz.regime.type.GROUNDS)
end

return entity

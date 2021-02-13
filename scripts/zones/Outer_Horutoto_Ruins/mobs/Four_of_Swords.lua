-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Four of Swords
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 663, 3, tpz.regime.type.GROUNDS)
end

return entity

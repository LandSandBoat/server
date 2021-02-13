-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Shrieker
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 656, 2, tpz.regime.type.GROUNDS)
end

return entity

-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Sodden Bones
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 623, 2, tpz.regime.type.GROUNDS)
end

return entity

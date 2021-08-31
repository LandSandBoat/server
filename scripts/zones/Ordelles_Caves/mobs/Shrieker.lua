-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Shrieker
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 656, 2, xi.regime.type.GROUNDS)
end

return entity

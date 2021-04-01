-----------------------------------
-- Area: Den of Rancor
--  Mob: Million Eyes
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 800, 1, xi.regime.type.GROUNDS)
end

return entity

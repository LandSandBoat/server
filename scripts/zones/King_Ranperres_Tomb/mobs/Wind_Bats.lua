-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Wind Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 632, 2, xi.regime.type.GROUNDS)
end

return entity

-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Lemures
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 636, 2, xi.regime.type.GROUNDS)
end

return entity

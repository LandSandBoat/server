-----------------------------------
-- Area: North Gustaberg
--  Mob: Rock Lizard
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 19, 2, xi.regime.type.FIELDS)
end

return entity

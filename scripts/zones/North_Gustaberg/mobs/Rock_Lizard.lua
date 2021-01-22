-----------------------------------
-- Area: North Gustaberg
--  Mob: Rock Lizard
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 19, 2, tpz.regime.type.FIELDS)
end

return entity

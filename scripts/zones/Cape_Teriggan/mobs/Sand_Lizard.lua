-----------------------------------
-- Area: Cape Teriggan
--  Mob: Sand Lizard
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 104, 2, tpz.regime.type.FIELDS)
end

return entity

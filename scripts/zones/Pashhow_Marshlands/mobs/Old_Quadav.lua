-----------------------------------
-- Area: Pashhow Marshlands
--  Mob: Old Quadav
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 60, 1, tpz.regime.type.FIELDS)
end

return entity

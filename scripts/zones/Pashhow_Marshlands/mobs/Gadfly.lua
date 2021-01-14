-----------------------------------
-- Area: Pashhow Marshlands
--  Mob: Gadfly
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 21, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 22, 2, tpz.regime.type.FIELDS)
end

return entity

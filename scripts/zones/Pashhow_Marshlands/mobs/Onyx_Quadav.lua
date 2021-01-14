-----------------------------------
-- Area: Pashhow Marshlands
--  Mob: Onyx Quadav
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 60, 1, tpz.regime.type.FIELDS)
end

return entity

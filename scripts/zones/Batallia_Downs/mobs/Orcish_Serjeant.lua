-----------------------------------
-- Area: Batallia Downs
--  Mob: Orcish Serjeant
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 74, 3, tpz.regime.type.FIELDS)
end

return entity

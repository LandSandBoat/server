-----------------------------------
-- Area: Batallia Downs
--  Mob: Orcish Impaler
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 74, 3, xi.regime.type.FIELDS)
end

return entity

-----------------------------------
-- Area: East Ronfaure
--  Mob: Orcish Mesmerizer
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 67, 1, tpz.regime.type.FIELDS)
end

return entity

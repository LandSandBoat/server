-----------------------------------
-- Area: West Ronfaure
--  Mob: Orcish Grappler
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 4, 1, tpz.regime.type.FIELDS)
end

return entity

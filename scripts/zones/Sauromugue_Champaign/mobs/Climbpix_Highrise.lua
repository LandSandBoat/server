-----------------------------------
-- Area: Sauromugue Champaign
--   NM: Climbpix Highrise
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 97, 2, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 98, 2, tpz.regime.type.FIELDS)
end

return entity

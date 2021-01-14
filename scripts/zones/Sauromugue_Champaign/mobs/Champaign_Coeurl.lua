-----------------------------------
-- Area: Sauromugue Champaign
--  Mob: Champaign Coeurl
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 98, 1, tpz.regime.type.FIELDS)
end

return entity

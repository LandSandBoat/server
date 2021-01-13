-----------------------------------
-- Area: East Ronfaure
--  Mob: Wild Sheep
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 68, 1, tpz.regime.type.FIELDS)
end

return entity

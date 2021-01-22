-----------------------------------
-- Area: West Ronfaure
--  Mob: Forest Funguar
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 3, 2, tpz.regime.type.FIELDS)
end

return entity

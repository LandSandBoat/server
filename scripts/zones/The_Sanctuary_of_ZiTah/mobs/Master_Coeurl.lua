-----------------------------------
-- Area: The Sanctuary of ZiTah
--  Mob: Master Coeurl
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 117, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 118, 2, tpz.regime.type.FIELDS)
end

return entity

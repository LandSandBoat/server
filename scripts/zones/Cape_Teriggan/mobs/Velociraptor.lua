-----------------------------------
-- Area: Cape Teriggan
--  Mob: Velociraptor
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 106, 2, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 107, 1, tpz.regime.type.FIELDS)
end

return entity

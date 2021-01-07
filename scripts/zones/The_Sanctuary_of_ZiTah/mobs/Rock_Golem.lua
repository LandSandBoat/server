-----------------------------------
-- Area: The Sanctuary of ZiTah
--  Mob: Rock Golem
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 118, 1, tpz.regime.type.FIELDS)
end

return entity

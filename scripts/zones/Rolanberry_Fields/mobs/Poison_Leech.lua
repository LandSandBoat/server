-----------------------------------
-- Area: Rolanberry Fields
--  Mob: Poison Leech
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 85, 2, tpz.regime.type.FIELDS)
end

return entity

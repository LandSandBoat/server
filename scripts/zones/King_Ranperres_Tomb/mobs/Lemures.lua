-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Lemures
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 636, 2, tpz.regime.type.GROUNDS)
end

return entity

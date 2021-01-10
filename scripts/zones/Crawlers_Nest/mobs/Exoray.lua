-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Exoray
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 690, 1, tpz.regime.type.GROUNDS)
end

return entity

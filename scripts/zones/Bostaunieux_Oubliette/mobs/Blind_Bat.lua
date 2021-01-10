-----------------------------------
-- Area: Bostaunieux Oubliette
--  Mob: Blind Bat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 615, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 617, 2, tpz.regime.type.GROUNDS)
end

return entity

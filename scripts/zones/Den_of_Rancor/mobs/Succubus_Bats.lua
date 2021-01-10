-----------------------------------
-- Area: Den of Rancor
--  Mob: Succubus Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 799, 1, tpz.regime.type.GROUNDS)
end

return entity

-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Goblin Mugger
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 604, 1, tpz.regime.type.GROUNDS)
end

return entity

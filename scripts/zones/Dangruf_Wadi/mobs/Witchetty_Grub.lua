-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Witchetty Grub
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 643, 1, tpz.regime.type.GROUNDS)
end

return entity

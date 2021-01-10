-----------------------------------
-- Area: Ifrit's Cauldron
--  Mob: Volcano Wasp
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 755, 1, tpz.regime.type.GROUNDS)
end

return entity

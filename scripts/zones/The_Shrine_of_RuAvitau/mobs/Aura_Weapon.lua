-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Aura Weapon
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 749, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 753, 1, tpz.regime.type.GROUNDS)
end

return entity

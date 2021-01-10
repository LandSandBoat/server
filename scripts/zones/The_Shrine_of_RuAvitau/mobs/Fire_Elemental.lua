-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Fire Elemental
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 750, 1, tpz.regime.type.GROUNDS)
end

return entity

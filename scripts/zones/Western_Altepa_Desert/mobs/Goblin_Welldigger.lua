-----------------------------------
-- Area: Western Altepa Desert
--  Mob: Goblin Welldigger
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 137, 1, tpz.regime.type.FIELDS)
end

return entity

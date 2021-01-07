-----------------------------------
-- Area: RoMaeve
--  Mob: Killing Weapon
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 119, 1, tpz.regime.type.FIELDS)
end

return entity

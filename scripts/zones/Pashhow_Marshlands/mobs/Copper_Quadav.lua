-----------------------------------
-- Area: Pashhow Marshlands
--  Mob: Copper Quadav
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 60, 1, tpz.regime.type.FIELDS)
end

return entity

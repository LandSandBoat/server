-----------------------------------
-- Area: South Gustaberg
--  Mob: Mole Crab
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 80, 2, tpz.regime.type.FIELDS)
end

return entity

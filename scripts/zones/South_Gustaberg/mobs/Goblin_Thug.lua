-----------------------------------
-- Area: South Gustaberg
--  Mob: Goblin Thug
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 79, 1, tpz.regime.type.FIELDS)
end

return entity

-----------------------------------
-- Area: Cape Teriggan
--  Mob: Goblin Alchemist
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 105, 2, tpz.regime.type.FIELDS)
end

return entity

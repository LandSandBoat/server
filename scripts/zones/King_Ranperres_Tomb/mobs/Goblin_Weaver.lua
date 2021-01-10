-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Goblin Weaver
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 631, 2, tpz.regime.type.GROUNDS)
end

return entity

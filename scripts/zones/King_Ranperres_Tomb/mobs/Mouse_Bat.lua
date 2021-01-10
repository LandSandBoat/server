-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Mouse Bat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 631, 1, tpz.regime.type.GROUNDS)
end

return entity

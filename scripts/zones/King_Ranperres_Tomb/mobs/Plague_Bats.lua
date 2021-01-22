-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Plague Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 634, 1, tpz.regime.type.GROUNDS)
end

return entity

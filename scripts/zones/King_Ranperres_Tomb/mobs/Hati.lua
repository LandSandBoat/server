-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Hati
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 637, 2, tpz.regime.type.GROUNDS)
end

return entity

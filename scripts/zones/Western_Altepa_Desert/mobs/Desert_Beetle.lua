-----------------------------------
-- Area: Western Altepa Desert
--  Mob: Desert Beetle
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 136, 1, tpz.regime.type.FIELDS)
end

return entity

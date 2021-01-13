-----------------------------------
-- Area: Western Altepa Desert
--  Mob: Desert Spider
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 134, 1, tpz.regime.type.FIELDS)
end

return entity

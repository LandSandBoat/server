-----------------------------------
-- Area: Western Altepa Desert
--  Mob: Antican Lanista
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 138, 2, tpz.regime.type.FIELDS)
end

return entity

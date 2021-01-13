-----------------------------------
-- Area: Western Altepa Desert
--  Mob: Antican Eques
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 135, 2, tpz.regime.type.FIELDS)
end

return entity

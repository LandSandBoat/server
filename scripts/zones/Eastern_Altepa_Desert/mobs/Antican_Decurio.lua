-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Antican Decurio
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 112, 1, tpz.regime.type.FIELDS)
end

return entity

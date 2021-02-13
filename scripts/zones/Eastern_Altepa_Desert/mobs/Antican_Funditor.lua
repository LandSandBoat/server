-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Antican Funditor
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 111, 1, tpz.regime.type.FIELDS)
end

return entity

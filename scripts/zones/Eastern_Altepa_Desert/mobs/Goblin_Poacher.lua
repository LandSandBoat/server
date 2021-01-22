-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Goblin Poacher
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 113, 1, tpz.regime.type.FIELDS)
end

return entity

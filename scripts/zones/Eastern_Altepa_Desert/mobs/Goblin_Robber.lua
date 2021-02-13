-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Goblin Robber
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 113, 2, tpz.regime.type.FIELDS)
end

return entity

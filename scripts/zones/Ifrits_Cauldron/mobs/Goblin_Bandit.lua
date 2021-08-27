-----------------------------------
-- Area: Ifrit's Cauldron
--  Mob: Goblin Bandit
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 757, 1, xi.regime.type.GROUNDS)
end

return entity

-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Mindgazer
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 811, 1, xi.regime.type.GROUNDS)
end

return entity

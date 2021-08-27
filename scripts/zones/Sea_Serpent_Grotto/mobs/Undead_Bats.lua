-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Undead Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 804, 2, xi.regime.type.GROUNDS)
end

return entity

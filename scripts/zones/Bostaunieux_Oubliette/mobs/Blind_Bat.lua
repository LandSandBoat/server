-----------------------------------
-- Area: Bostaunieux Oubliette
--  Mob: Blind Bat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 615, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 617, 2, xi.regime.type.GROUNDS)
end

return entity

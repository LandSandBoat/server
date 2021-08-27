-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Snaggletooth Peapuk
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 726, 2, xi.regime.type.GROUNDS)
end

return entity

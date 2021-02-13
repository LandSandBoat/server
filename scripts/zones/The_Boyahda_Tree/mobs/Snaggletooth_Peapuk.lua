-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Snaggletooth Peapuk
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 726, 2, tpz.regime.type.GROUNDS)
end

return entity

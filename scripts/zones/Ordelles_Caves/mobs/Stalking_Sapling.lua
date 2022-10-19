-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Stalking Sapling
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 655, 1, xi.regime.type.GROUNDS)
end

return entity

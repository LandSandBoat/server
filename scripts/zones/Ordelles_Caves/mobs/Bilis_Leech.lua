-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Bilis Leech
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 662, 1, xi.regime.type.GROUNDS)
end

return entity

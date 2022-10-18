-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Ancient Bat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 659, 1, xi.regime.type.GROUNDS)
end

return entity

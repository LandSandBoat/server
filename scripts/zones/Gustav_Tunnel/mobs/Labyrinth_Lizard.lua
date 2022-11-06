-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Labyrinth Lizard
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 763, 1, xi.regime.type.GROUNDS)
end

return entity

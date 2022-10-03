-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Boulder Eater
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 770, 1, xi.regime.type.GROUNDS)
end

return entity

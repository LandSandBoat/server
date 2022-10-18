-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Wadi Leech
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 641, 2, xi.regime.type.GROUNDS)
end

return entity

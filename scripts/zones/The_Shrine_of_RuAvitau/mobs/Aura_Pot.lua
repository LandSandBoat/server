-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Aura Pot
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 749, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 751, 1, xi.regime.type.GROUNDS)
end

return entity

-----------------------------------
-- Area: La Theine Plateau
--  Mob: Grass Funguar
-----------------------------------
require('scripts/quests/tutorial')
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 6, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 71, 2, xi.regime.type.FIELDS)
    xi.tutorial.onMobDeath(player)
end

return entity

-----------------------------------
-- Area: La Theine Plateau
--  Mob: Mad Sheep
-----------------------------------
require('scripts/quests/tutorial')
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 69, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 70, 1, xi.regime.type.FIELDS)
    xi.tutorial.onMobDeath(player)
end

return entity

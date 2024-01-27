-----------------------------------
-- Area: La Theine Plateau
--  Mob: Akbaba
-----------------------------------
require('scripts/quests/tutorial')
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 69, 2, xi.regime.type.FIELDS)
    xi.tutorial.onMobDeath(player)
end

return entity

-----------------------------------
-- Area: Konschtat Highlands
--  Mob: Mist Lizard
-----------------------------------
require('scripts/quests/tutorial')
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 20, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 82, 2, xi.regime.type.FIELDS)
    xi.tutorial.onMobDeath(player)
end

return entity

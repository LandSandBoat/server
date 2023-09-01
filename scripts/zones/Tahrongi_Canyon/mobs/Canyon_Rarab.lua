-----------------------------------
-- Area: Tahrongi Canyon
--  Mob: Canyon Rarab
-----------------------------------
require('scripts/quests/tutorial')
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 94, 1, xi.regime.type.FIELDS)
    xi.tutorial.onMobDeath(player)
end

return entity

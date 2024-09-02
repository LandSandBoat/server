-----------------------------------
-- Area: Tahrongi Canyon
--  Mob: Killer Bee
-----------------------------------
require('scripts/quests/tutorial')
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 30, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 95, 2, xi.regime.type.FIELDS)
    xi.tutorial.onMobDeath(player)
end

return entity

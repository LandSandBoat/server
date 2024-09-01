-----------------------------------
-- Area: Tahrongi Canyon
--  Mob: Pygmaioi
-----------------------------------
require('scripts/quests/tutorial')
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 94, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 95, 1, xi.regime.type.FIELDS)
    xi.tutorial.onMobDeath(player)
end

return entity

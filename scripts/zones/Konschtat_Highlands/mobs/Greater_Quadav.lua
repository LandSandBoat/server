-----------------------------------
-- Area: Konschtat Highlands
--  Mob: Greater Quadav
-----------------------------------
require('scripts/quests/tutorial')
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 83, 1, xi.regime.type.FIELDS)
    xi.tutorial.onMobDeath(player)
end

return entity

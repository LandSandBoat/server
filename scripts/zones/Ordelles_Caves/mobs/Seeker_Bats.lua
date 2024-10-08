-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Seeker Bats
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 658, 1, xi.regime.type.GROUNDS)
end

return entity

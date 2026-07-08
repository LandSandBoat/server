-----------------------------------
-- Area: Den of Rancor
--  Mob: Cave Worm
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 796, 2, xi.regime.type.GROUNDS)
end

return entity

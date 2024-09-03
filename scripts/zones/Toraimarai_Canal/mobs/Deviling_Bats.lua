-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Deviling Bats
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 622, 2, xi.regime.type.GROUNDS)
end

return entity

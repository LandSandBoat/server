-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Hell Bat
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 618, 1, xi.regime.type.GROUNDS)
end

return entity

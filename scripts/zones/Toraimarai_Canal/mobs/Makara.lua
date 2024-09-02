-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Makara
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 618, 2, xi.regime.type.GROUNDS)
end

return entity

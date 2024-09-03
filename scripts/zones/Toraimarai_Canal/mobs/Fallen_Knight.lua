-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Fallen Knight
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 619, 1, xi.regime.type.GROUNDS)
end

return entity

-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Makara
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 764, 2, xi.regime.type.GROUNDS)
end

return entity

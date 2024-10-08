-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Hell Bat
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 763, 3, xi.regime.type.GROUNDS)
end

return entity

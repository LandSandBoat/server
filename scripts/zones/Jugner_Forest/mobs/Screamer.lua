-----------------------------------
-- Area: Jugner Forest
--  Mob: Screamer
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 58, 2, xi.regime.type.FIELDS)
end

return entity

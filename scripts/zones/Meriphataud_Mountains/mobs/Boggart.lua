-----------------------------------
-- Area: Meriphataud Mountains
--  Mob: Boggart
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 63, 2, xi.regime.type.FIELDS)
end

return entity

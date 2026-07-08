-----------------------------------
-- Area: Meriphataud Mountains
--   NM: Tsaagan
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 39, 1, xi.regime.type.FIELDS)
end

return entity

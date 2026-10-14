-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Fallen Major
-- Note: Place holder Hovering Hotpot
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 703, 2, xi.regime.type.FIELDS)
end

return entity

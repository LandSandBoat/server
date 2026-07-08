-----------------------------------
-- Area: Qufim Island
--  Mob: Seeker Bats
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 42, 2, xi.regime.type.FIELDS)
end

return entity

-----------------------------------
-- Area: West Ronfaure
--  Mob: Goblin Weaver
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 56, 2, xi.regime.type.FIELDS)
end

return entity

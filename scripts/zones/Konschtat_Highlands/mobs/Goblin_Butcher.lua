-----------------------------------
-- Area: Konschtat Highlands
--  Mob: Goblin Butcher
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 84, 3, xi.regime.type.FIELDS)
end

return entity

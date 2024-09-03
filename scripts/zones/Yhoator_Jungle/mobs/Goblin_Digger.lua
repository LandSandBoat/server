-----------------------------------
-- Area: Yhoator Jungle
--  Mob: Goblin Digger
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 129, 2, xi.regime.type.FIELDS)
end

return entity

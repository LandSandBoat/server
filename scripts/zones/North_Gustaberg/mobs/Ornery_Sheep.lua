-----------------------------------
-- Area: North Gustaberg
--  Mob: Ornery Sheep
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 59, 2, xi.regime.type.FIELDS)
end

return entity

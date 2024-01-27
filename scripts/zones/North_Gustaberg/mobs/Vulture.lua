-----------------------------------
-- Area: North Gustaberg
--  Mob: Vulture
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 18, 1, xi.regime.type.FIELDS)
end

return entity

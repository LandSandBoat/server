-----------------------------------
-- Area: South Gustaberg
--  Mob: Stone Eater
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 77, 1, xi.regime.type.FIELDS)
end

return entity

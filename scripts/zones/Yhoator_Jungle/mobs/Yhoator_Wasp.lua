-----------------------------------
-- Area: Yhoator Jungle
--  Mob: Yhoator Wasp
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 130, 2, xi.regime.type.FIELDS)
end

return entity

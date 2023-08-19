-----------------------------------
-- Area: Yhoator Jungle
--  Mob: Young Opo-opo
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 131, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 132, 2, xi.regime.type.FIELDS)
end

return entity

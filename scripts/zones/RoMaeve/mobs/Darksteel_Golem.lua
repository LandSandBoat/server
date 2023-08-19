-----------------------------------
-- Area: RoMaeve
--  Mob: Darksteel Golem
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 122, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 123, 2, xi.regime.type.FIELDS)
end

return entity

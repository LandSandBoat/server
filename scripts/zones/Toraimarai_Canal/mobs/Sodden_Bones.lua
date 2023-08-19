-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Sodden Bones
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 623, 2, xi.regime.type.GROUNDS)
end

return entity

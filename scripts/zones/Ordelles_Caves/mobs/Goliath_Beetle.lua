-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Goliath Beetle
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 660, 1, xi.regime.type.GROUNDS)
end

return entity

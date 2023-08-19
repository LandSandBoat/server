-----------------------------------
-- Area: Quicksand Caves
--  Mob: Sand Tarantula
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 819, 1, xi.regime.type.GROUNDS)
end

return entity

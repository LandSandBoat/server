-----------------------------------
-- Area: Quicksand Caves
--  Mob: Sand Digger
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 814, 1, xi.regime.type.GROUNDS)
end

return entity

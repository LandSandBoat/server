-----------------------------------
-- Area: Quicksand Caves
--  Mob: Girtab
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 818, 1, xi.regime.type.GROUNDS)
end

return entity

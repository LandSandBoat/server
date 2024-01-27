-----------------------------------
-- Area: Lower Delkfutt's Tower
--  Mob: Gigas Sculptor
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 778, 2, xi.regime.type.GROUNDS)
end

return entity

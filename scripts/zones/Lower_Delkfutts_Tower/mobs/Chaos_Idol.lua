-----------------------------------
-- Area: Lower Delkfutt's Tower
--  Mob: Chaos Idol
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 779, 2, xi.regime.type.GROUNDS)
end

return entity

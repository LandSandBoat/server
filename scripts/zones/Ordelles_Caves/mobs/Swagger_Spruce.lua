-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Swagger Spruce
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 662, 2, xi.regime.type.GROUNDS)
end

return entity

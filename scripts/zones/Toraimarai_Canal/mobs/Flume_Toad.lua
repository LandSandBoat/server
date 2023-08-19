-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Flume Toad
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 625, 1, xi.regime.type.GROUNDS)
end

return entity

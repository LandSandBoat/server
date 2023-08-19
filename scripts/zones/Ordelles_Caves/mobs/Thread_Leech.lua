-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Thread Leech
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 655, 2, xi.regime.type.GROUNDS)
end

return entity

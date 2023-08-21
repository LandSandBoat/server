-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Bilis Leech
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 662, 1, xi.regime.type.GROUNDS)
end

return entity

-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Shrieker
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 656, 2, xi.regime.type.GROUNDS)
end

return entity

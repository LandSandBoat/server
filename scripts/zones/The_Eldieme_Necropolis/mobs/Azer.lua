-----------------------------------
-- Area: The Eldieme Necropolis
--  Mob: Azer
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 673, 2, xi.regime.type.GROUNDS)
end

return entity

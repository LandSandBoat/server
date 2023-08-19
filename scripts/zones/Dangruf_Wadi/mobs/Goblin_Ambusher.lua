-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Goblin Ambusher
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 640, 1, xi.regime.type.GROUNDS)
end

return entity

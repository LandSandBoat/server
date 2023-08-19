-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Goblin Conjurer
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 640, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 645, 1, xi.regime.type.GROUNDS)
end

return entity

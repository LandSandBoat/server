-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Goblin Bushwhacker
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 640, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 645, 3, xi.regime.type.GROUNDS)
end

return entity

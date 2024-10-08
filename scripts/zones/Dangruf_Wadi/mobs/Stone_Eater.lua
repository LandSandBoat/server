-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Stone Eater
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 639, 1, xi.regime.type.GROUNDS)
end

return entity

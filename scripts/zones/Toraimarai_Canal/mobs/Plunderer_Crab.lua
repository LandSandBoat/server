-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Plunderer Crab
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 623, 1, xi.regime.type.GROUNDS)
end

return entity

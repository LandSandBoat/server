-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Kaboom
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 709, 2, xi.regime.type.GROUNDS)
end

return entity

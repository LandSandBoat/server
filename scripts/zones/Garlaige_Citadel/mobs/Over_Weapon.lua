-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Over Weapon
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 705, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 708, 1, xi.regime.type.GROUNDS)
end

return entity

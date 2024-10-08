-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Siege Bat
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 704, 1, xi.regime.type.GROUNDS)
end

return entity

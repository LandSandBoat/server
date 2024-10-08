-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Warden Beetle
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 710, 2, xi.regime.type.GROUNDS)
end

return entity

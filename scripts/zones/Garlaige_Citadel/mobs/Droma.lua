-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Droma
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 707, 1, xi.regime.type.GROUNDS)
end

return entity

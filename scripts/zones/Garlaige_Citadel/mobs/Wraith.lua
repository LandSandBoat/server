-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Wraith
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 708, 3, xi.regime.type.GROUNDS)
end

return entity

-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Robber Crab
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 765, 1, xi.regime.type.GROUNDS)
end

return entity

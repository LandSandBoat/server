-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Doom Guard
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 765, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 767, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 768, 1, xi.regime.type.GROUNDS)
end

return entity

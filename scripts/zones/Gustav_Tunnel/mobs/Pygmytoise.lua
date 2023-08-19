-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Pygmytoise
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 770, 2, xi.regime.type.GROUNDS)
end

return entity

-----------------------------------
-- Area: Den of Rancor
--  Mob: Million Eyes
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 800, 1, xi.regime.type.GROUNDS)
end

return entity

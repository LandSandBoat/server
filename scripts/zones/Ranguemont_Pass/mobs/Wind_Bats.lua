-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Wind Bats
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 602, 1, xi.regime.type.GROUNDS)
end

return entity

-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Wind Bats
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 632, 2, xi.regime.type.GROUNDS)
end

return entity

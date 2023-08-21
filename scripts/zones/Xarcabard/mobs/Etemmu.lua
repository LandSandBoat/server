-----------------------------------
-- Area: Xarcabard
--  Mob: Etemmu
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 51, 2, xi.regime.type.FIELDS)
end

return entity

-----------------------------------
-- Area: Rolanberry Fields
--  Mob: Copper Quadav
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 87, 2, xi.regime.type.FIELDS)
end

return entity

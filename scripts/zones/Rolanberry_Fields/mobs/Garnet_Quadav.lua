-----------------------------------
-- Area: Rolanberry Fields
--  Mob: Garnet Quadav
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 87, 2, xi.regime.type.FIELDS)
end

return entity

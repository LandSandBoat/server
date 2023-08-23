-----------------------------------
-- Area: Pashhow Marshlands
--  Mob: Copper Quadav
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 60, 1, xi.regime.type.FIELDS)
end

return entity

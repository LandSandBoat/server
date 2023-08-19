-----------------------------------
-- Area: Sauromugue Champaign
--  Mob: Diving Beetle
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 40, 2, xi.regime.type.FIELDS)
end

return entity

-----------------------------------
-- Area: Sauromugue Champaign
--  Mob: Sauromugue Skink
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 97, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 99, 1, xi.regime.type.FIELDS)
end

return entity

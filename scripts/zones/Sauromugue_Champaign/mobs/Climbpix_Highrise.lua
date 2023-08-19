-----------------------------------
-- Area: Sauromugue Champaign
--   NM: Climbpix Highrise
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 97, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 98, 2, xi.regime.type.FIELDS)
end

return entity

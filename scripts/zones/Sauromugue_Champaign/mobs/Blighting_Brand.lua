-----------------------------------
-- Area: Sauromugue Champaign
--   NM: Blighting Brand
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 275)
    xi.regime.checkRegime(player, mob, 100, 2, xi.regime.type.FIELDS)
end

return entity

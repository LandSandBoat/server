-----------------------------------
-- Area: Pashhow Marshlands
--   NM: Jolly Green
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 212)
    xi.regime.checkRegime(player, mob, 60, 3, xi.regime.type.FIELDS)
    xi.magian.onMobDeath(mob, player, optParams, set{ 942 })
end

return entity

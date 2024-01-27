-----------------------------------
-- Area: Pashhow Marshlands
--   NM: Ni'Zho Bladebender
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 60, 1, xi.regime.type.FIELDS)
    xi.hunts.checkHunt(mob, player, 214)
    xi.magian.onMobDeath(mob, player, optParams, set{ 893 })
end

return entity

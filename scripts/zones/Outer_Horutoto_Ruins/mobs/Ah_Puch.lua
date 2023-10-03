-----------------------------------
-- Area: Outer Horutoto Ruins (194)
--   NM: Ah Puch
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 291)
    xi.magian.onMobDeath(mob, player, optParams, set{ 513 })
end

return entity

-----------------------------------
-- Area: Bibiki Bay
--   NM: Intulo
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 265)
    xi.magian.onMobDeath(mob, player, optParams, set{ 71, 285, 433 })
end

return entity

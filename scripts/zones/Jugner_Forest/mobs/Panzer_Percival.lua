-----------------------------------
-- Area: Jugner Forest
--   NM: Panzer Percival
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 157)
    xi.magian.onMobDeath(mob, player, optParams, set{ 282 })
end

return entity

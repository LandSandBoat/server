-----------------------------------
-- Area: Oldton Movalpolos
--   NM: Bugbear Strongman
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.magian.onMobDeath(mob, player, optParams, set{ 5 })
    xi.hunts.checkHunt(mob, player, 244)
end

return entity

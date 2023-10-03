-----------------------------------
-- Area: Garlaige Citadel (164)
--   NM: Hovering Hotpot
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 301)
    xi.magian.onMobDeath(mob, player, optParams, set{ 7, 517, 896 })
end

return entity

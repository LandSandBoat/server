-----------------------------------
-- Area: Batallia Downs [S]
--   NM: La Velue
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 491)
    xi.magian.onMobDeath(mob, player, optParams, set{ 6, 516, 895 })
end

return entity

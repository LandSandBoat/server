-----------------------------------
-- Area: Beaucedine Glacier
--   NM: Gargantua
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 312)
    xi.magian.onMobDeath(mob, player, optParams, set{ 153, 367, 581 })
end

return entity

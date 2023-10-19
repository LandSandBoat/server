-----------------------------------
-- Area: Misareaux Coast
--   NM: Okyupete
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 446)
    xi.magian.onMobDeath(mob, player, optParams, set{ 221, 649, 715, 946 })
end

return entity

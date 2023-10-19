-----------------------------------
-- Area: North Gustaberg [S]
--   NM: Ankabut
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 500)
    xi.magian.onMobDeath(mob, player, optParams, set{ 220, 648, 714, 945 })
end

return entity

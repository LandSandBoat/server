-----------------------------------
-- Area: Misareaux Coast
--   NM: Okyupete
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 446)
end

return entity

-----------------------------------
-- Area: Mamook
--   NM: Venomfang
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 459)
end

return entity

-----------------------------------
-- Area: Jugner Forest
--   NM: Panzer Percival
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 157)
end

return entity

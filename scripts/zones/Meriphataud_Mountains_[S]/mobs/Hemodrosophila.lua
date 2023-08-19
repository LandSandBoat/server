-----------------------------------
-- Area: Meriphataud Mountains [S]
--   NM: Hemodrosophila
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 527)
end

return entity

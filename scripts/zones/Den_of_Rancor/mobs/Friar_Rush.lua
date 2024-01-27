-----------------------------------
-- Area: Den of Rancor
--   NM: Friar Rush
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 394)
end

return entity

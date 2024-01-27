-----------------------------------
-- Area: RoMaeve
--   NM: Nightmare Vase
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 327)
end

return entity

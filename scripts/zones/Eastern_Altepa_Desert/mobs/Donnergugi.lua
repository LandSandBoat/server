-----------------------------------
-- Area: Eastern Altepa Desert
--   NM: Donnergugi
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 410)
end

return entity

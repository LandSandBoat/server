-----------------------------------
-- Area: Western Altepa Desert
--   NM: Dahu
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 413)
end

return entity

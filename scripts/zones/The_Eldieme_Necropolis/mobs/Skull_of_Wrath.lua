-----------------------------------
-- Area: The Eldieme Necropolis
--   NM: Skull of Wrath
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 190)
end

return entity

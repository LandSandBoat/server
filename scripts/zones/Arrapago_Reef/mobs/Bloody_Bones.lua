-----------------------------------
-- Area: Arrapago Reef
--   NM: Bloody Bones
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 472)
end

return entity

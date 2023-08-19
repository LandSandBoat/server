-----------------------------------
-- Area: La Theine Plateau
--   NM: Slumbering Samwell
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 155)
end

return entity

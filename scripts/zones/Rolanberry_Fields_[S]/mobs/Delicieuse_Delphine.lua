-----------------------------------
-- Area: Rolanberry Fields [S]
--   NM: Delicieuse Delphine
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 513)
end

return entity

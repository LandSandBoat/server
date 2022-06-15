-----------------------------------
-- Area: Riverne - Site A01
--  Mob: Aiatar
-----------------------------------
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    UpdateNMSpawnPoint(mob:getID())
<<<<<<< HEAD
end

return entity
=======
end
>>>>>>> 6d39d7b186 (Aiatar)

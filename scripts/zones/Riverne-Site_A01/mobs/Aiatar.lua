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
<<<<<<< HEAD
end

return entity
<<<<<<< HEAD
=======
end
>>>>>>> 6d39d7b186 (Aiatar)
=======
end
>>>>>>> 86c674b976 (Update Aiatar.lua)
=======
>>>>>>> 806ca478e9 (Update Aiatar.lua)

-----------------------------------
-- Area: Riverne - Site A01
--  Mob: Flamedrake PH
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_A01/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.mobOnDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.AIATAR_PH, 10, 75600) -- 50 minutes
end

<<<<<<< HEAD
<<<<<<< HEAD
return entity
=======
return entity
>>>>>>> 6d39d7b186 (Aiatar)
=======
return entity
>>>>>>> c2be120575 (Update Flamedrake.lua)

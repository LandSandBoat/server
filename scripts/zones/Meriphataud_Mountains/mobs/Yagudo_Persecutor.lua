-----------------------------------
-- Area: Meriphataud Mountains
--  Mob: Yagudo Persecutor
-- Note: PH for Naa Zeku the Unwaiting
-----------------------------------
local ID = require("scripts/zones/Meriphataud_Mountains/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.NAA_ZEKU_THE_UNWAITING_PH, 10, 3600) -- 1 hour
end

return entity

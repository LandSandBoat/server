-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Razorjaw Pugil
-- Note: PH for Sea Hog
-----------------------------------
local ID = require("scripts/zones/Sea_Serpent_Grotto/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.SEA_HOG_PH, 10, 3600) -- 1 hour
end

return entity

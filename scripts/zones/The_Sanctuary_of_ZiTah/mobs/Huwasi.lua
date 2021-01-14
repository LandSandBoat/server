-----------------------------------
-- Area: The Sanctuary of Zi'Tah
--   NM: Huwasi
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 326)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
end

return entity

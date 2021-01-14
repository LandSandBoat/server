-----------------------------------
-- Area: Toraimarai Canal
--   NM: Brazen Bones
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 286)
end

return entity

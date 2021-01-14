-----------------------------------
-- Area: South Gustaberg
--   NM: Carnero
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 202)
end

return entity

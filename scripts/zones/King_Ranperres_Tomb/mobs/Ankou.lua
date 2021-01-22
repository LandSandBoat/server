-----------------------------------
-- Area: King Ranperres Tomb
--   NM: Ankou
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 176)
end

return entity

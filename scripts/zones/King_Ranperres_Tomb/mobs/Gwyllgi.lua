-----------------------------------
-- Area: King Ranperres Tomb
--   NM: Gwyllgi
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 177)
end

return entity

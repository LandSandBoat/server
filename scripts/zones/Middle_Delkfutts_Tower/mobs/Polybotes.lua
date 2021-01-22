-----------------------------------
-- Area: Middle Delkfutt's Tower
--   NM: Polybotes
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 335)
end

return entity

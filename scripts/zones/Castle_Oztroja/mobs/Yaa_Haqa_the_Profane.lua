-----------------------------------
-- Area: Castle Oztroja (151)
--   NM: Yaa Haqa the Profane
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 305)
end

return entity

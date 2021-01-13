-----------------------------------
-- Area: Lower Delkfutt's Tower
--   NM: Hippolytos
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 341)
end

return entity

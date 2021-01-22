-----------------------------------
-- Area: Quicksand Caves
--   NM: Antican Proconsul
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 430)
end

return entity

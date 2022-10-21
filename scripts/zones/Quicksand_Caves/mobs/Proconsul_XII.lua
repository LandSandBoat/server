-----------------------------------
-- Area: Quicksand Caves
--   NM: Proconsul XII
-----------------------------------
require("scripts/globals/hunts")
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 437)
end

return entity

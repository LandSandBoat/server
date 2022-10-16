-----------------------------------
-- Area: Quicksand Caves
--   NM: Triarius X-XV
-----------------------------------
require("scripts/globals/hunts")
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 436)
end

return entity

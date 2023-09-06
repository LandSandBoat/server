-----------------------------------
-- Area: Quicksand Caves
--   NM: Tribunus VII-I
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 434)
end

return entity

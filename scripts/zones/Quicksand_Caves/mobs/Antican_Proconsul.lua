-----------------------------------
-- Area: Quicksand Caves
--   NM: Antican Proconsul
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 430)
end

return entity

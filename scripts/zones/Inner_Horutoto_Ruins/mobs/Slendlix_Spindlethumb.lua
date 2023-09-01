-----------------------------------
-- Area: Inner Horutoto Ruins
--   NM: Slendlix Spindlethumb
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 289)
end

return entity

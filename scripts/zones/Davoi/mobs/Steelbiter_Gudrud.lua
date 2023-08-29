-----------------------------------
-- Area: Davoi
--   NM: Steelbiter Gudrud
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 194)
end

return entity

-----------------------------------
-- Area: Davoi
--   NM: Tigerbane Bakdak
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 193)
end

return entity

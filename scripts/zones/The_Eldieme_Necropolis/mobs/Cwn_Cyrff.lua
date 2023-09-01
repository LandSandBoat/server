-----------------------------------
-- Area: The Eldieme Necropolis
--   NM: Cwn Cyrff
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 191)
end

return entity

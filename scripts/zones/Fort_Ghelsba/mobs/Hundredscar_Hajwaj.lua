-----------------------------------
-- Area: Fort Ghelsba
--   NM: Hundredscar Hajwaj
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 172)
end

return entity

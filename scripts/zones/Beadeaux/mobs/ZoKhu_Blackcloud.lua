-----------------------------------
-- Area: Beadeaux (254)
--   NM: Zo'Khu Blackcloud
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 242)
    xi.magian.onMobDeath(mob, player, optParams, set{ 646 })
end

return entity

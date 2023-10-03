-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Seww the Squidlimbed
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 374)
    xi.magian.onMobDeath(mob, player, optParams, set{ 219, 647, 713, 944 })
end

return entity
